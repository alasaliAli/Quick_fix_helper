from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth import login, logout
from .middlewares import guest, auth, admin_required, user_required
from .models import TicketCategory, Article, FAQ, TicketAttachment, Ticket, Contact, Profile
from .forms import TicketCategoryForm, ContactCreationForm , CustomUserCreationForm,StaffCreationForm, ArticleCreationForm, FAQCreationForm, TicketCreationForm, TicketRemarksCreationForm, ProfileForm, TicketRemark
from django.contrib import messages
from django.core.mail import EmailMessage
from django.contrib.auth.models import User
import random
import string
from datetime import datetime
from django.utils.dateformat import format
import json
from django.http import JsonResponse
from django.db.models import Q
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.contrib.auth.decorators import login_required

# index view
def index_view(request):
    query = request.GET.get('q')
    if query:
        articles_list = Article.objects.filter(
            Q(title__icontains=query) | Q(description__icontains=query)
        )
    else:
        articles_list = Article.objects.all()

    paginator = Paginator(articles_list, 5)  # Show 5 articles per page
    page = request.GET.get('page')

    try:
        articles = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        articles = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        articles = paginator.page(paginator.num_pages)

    return render(request, 'front/index.html', {'articles': articles})

# faq view
def faq_view(request):
    faqs = FAQ.objects.all()
    return render(request, 'front/faqs.html', {'faqs': faqs})

# contact view
def contact_view(request):
    if request.method == 'POST':
        form = ContactCreationForm(request.POST)
        if form.is_valid():
            contact = form.save(commit=False)
            contact.name = form.cleaned_data['name']
            contact.email = form.cleaned_data['email']
            contact.subject = form.cleaned_data['subject']
            contact.message = form.cleaned_data['message']
            contact.save()
            messages.success(request, 'Message sent successfully!')
            return redirect('contact')  # Redirect to avoid re-posting form on refresh
        else:
            messages.error(request, 'Error! Message sending failed. Please correct the errors below.')
    else:
        initial_data = {'name': '', 'email': '', 'subject': '', 'message': ''}
        form = ContactCreationForm(initial = initial_data)

    return render(request, 'front/contact.html', {'form': form})

@admin_required
def manage_contact_delete_view(request, feedback_id):
    contact = get_object_or_404(Contact, pk=feedback_id)
    if request.method == 'POST':
        contact.delete()
        messages.success(request, 'Contact deleted successfully!')
        return redirect('admin.manage-feedback.index')
    messages.error(request, 'Error! deleting feedback!')
    return redirect('admin.manage-feedback.index')

# contact view
@admin_required
def manage_contact_index_view(request):
    contacts = Contact.objects.all().order_by('-id')
    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'admin/contact/index.html', {'contacts': contacts, "profile": profile})

# article view
def articles_view(request):
    articles_list = Article.objects.all().order_by('-published_date')
    paginator = Paginator(articles_list, 10)  # Show 5 articles per page
    page = request.GET.get('page')

    try:
        articles = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        articles = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        articles = paginator.page(paginator.num_pages)

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'front/article.html', {'articles': articles, "profile": profile})    

# register view
@guest
def register_view(request):
    if request.method == 'POST':
        form  = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('user.dashboard')
    else:
        initial_data = {'username': '','email': '', 'password1': '', 'password2':''}
        form = CustomUserCreationForm(initial = initial_data)
    return render(request, 'auth/registration.html', {'form': form})            

# login view
@guest
def login_view(request):
    if request.method == 'POST':
        form  = AuthenticationForm(request, data = request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            if user.is_superuser or user.is_staff:
                    return redirect('admin.dashboard')
            else:
                return redirect('user.dashboard')
    else:
        initial_data = {'username': '', 'password': ''}
        form = AuthenticationForm(initial = initial_data)
    return render(request, 'auth/login.html', {'form': form})            

# 
#dashboard view
@user_required
def dashboard_view(request):
    # Calculate counts of total tickets, resolved tickets, and tickets in processing
    total_tickets_count = Ticket.objects.filter(user_id=request.user).count()
    resolved_tickets_count = Ticket.objects.filter(user_id=request.user, status=2).count()  # Assuming '2' is the status for resolved tickets
    in_processing_tickets_count = Ticket.objects.filter(user_id=request.user, status='0').count()  # Assuming '1' is the status for tickets in processing
    tickets = Ticket.objects.filter(user_id=request.user)  # Assuming '0' is the status for pending tickets

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    context = {
        'total_tickets_count': total_tickets_count,
        'resolved_tickets_count': resolved_tickets_count,
        'in_processing_tickets_count': in_processing_tickets_count,
        'tickets': tickets,
        'profile': profile
    }
    return render(request, 'user/dashboard.html', context)

def admin_profile(request):
    try:
        _profile = Profile.objects.get(user=request.user.id)
    except:
        _profile = None

    user = User.objects.get(id=request.user.id)
    form = ProfileForm(initial={'user': request.user.id})
    image = None

    if _profile:
        image = _profile.image.url

    profileData = {
        'image': image,
        'first_name': request.user.first_name,
        'last_name': request.user.last_name,
        'email': request.user.email,
    }

    if request.method == 'POST':
        user.first_name =  request.POST['first_name']
        user.last_name =  request.POST['last_name']
        user.email =  request.POST['email']

        if request.POST['password']:
            user.set_password(request.POST['password'])

        user.save()

        if _profile:
            form = ProfileForm(request.POST, request.FILES, instance=_profile)
        else:
            form = ProfileForm(request.POST, request.FILES)

        if form.is_valid():
            form.save()

    return render(request, 'admin/profile/index.html', {'profileData': profileData, 'form': form, 'profile': _profile})



def user_profile(request):
    try:
        _profile = Profile.objects.get(user=request.user.id)
    except:
        _profile = None

    user = User.objects.get(id=request.user.id)
    form = ProfileForm(initial={'user': request.user.id})
    image = None

    if _profile:
        image = _profile.image.url

    profileData = {
        'image': image,
        'first_name': request.user.first_name,
        'last_name': request.user.last_name,
        'email': request.user.email,
    }

    if request.method == 'POST':
        user.first_name =  request.POST['first_name']
        user.last_name =  request.POST['last_name']
        user.email =  request.POST['email']

        if request.POST['password']:
            user.set_password(request.POST['password'])

        user.save()

        if _profile:
            form = ProfileForm(request.POST, request.FILES, instance=_profile)
        else:
            form = ProfileForm(request.POST, request.FILES)

        if form.is_valid():
            form.save()

    return render(request, 'user/profile/index.html', {'profileData': profileData, 'profile': _profile, 'form': form})

# logout view
@auth
def logout_view(request):
    logout(request)
    return redirect('login')    

# ******** User Views ********
@user_required
def create_ticket_view(request):
    
    categories = TicketCategory.objects.all()
    if request.method == 'POST':
        form = TicketCreationForm(request.POST)
        if form.is_valid():
            ticket = form.save(commit=False)
            ticket.user_id = request.user
            subject = "Quick Fix Helper: "+ ticket.priority +" - New ticket has been added from "+request.user.first_name
            message = "New Message in " + ticket.category_id.title + " \n " + ticket.description

            ticket.status = 0
            ticket.ticket_token = generate_ticket_token()
            ticket.save()
            # Handle attachments
            for file in request.FILES.getlist('attachments[]'):
                # Save the file to the designated directory
                attachment = TicketAttachment.objects.create(ticket_id=ticket, file=file, file_type=file.content_type)
            
            try:
                msg = EmailMessage(subject, message, "alasail.albusaidi@gmail.com", ["alasail.albusaidi@gmail.com"])
                msg.send()
            except Exception as err:
                print(err)
                #pass
            messages.success(request, 'Ticket Submitted successfully!')
            return redirect('user.dashboard')  
    else:
        initial_data = {'subject' : '', 'description' : '', 'priority' : '', 'category_id' : ''}
        form = TicketCreationForm(initial = initial_data)
    return render(request, 'user/ticket/create.html', {'form': form, 'categories': categories})

@user_required
def user_view_ticket_view(request):
    return render(request, 'user/ticket/view.html') 

@user_required
def search_ticket_view(request, token):
    try:
        ticket = Ticket.objects.get(ticket_token=token)
        ticket_id = ticket.id
        ticket_output = f'<p>Ticket # {ticket.ticket_token} was created on {ticket.created_at.strftime("%B %d, %Y")} at {ticket.created_at.strftime("%I:%M %p")}</p>'
        ticket_output += f'<p><b>Ticket Status: </b>{ticket.get_status_display()}</p>'
        ticket_output += f'<p><b>Issue: </b>{ticket.subject}</p>'
        ticket_output += f'<p><b>Details: </b>{ticket.description}</p>'

        if ticket.status != '2':
            ticket_output += f'<textarea id="addComment" class="form-control col-12" placeholder="Add comment"></textarea>'
            ticket_output += f'<div class="p-3 text-danger" id="error"></div><button id="add-new" class="btn btn-primary mt-3" onClick="addTicketReply()">Send</button>'

        ticket_remarks_output = '<div class="card">'
        ticket_remarks_output += '<div class="card-header">Status/ Remarks</div>'
        ticket_remarks_output += '<div class="card-body">'

        ticket_remarks = ticket.ticket_remarks.all().order_by('-created_at')

        if ticket_remarks.exists():
            for remarks in ticket_remarks:
                ticket_remarks_output += '<div class="card">'
                ticket_remarks_output += '<div class="card-body">'
                ticket_remarks_output += '<blockquote class="blockquote">'
                ticket_remarks_output += f'<p class="mb-0" style="font-size: 16px;">{remarks.status_remarks}</p>'
                ticket_remarks_output += f'<footer class="blockquote-footer" style="line-height: 5; font-size: 12px;">{remarks.created_at.strftime("%B %d, %Y, %I:%M %p")} <cite title="Source Title">Elum Team</cite></footer>'
                ticket_remarks_output += '</blockquote>'
                ticket_remarks_output += '</div>'
                ticket_remarks_output += '</div>'
        else:
            ticket_remarks_output += '<p>No Remarks Found</p>'

        ticket_remarks_output += '</div>'
        ticket_remarks_output += '</div>'

        data = {
            "ticket_id": ticket_id,
            "ticket": ticket_output,
            "ticket_remarks": ticket_remarks_output
        }
        return JsonResponse(data)

    except Ticket.DoesNotExist:
        data = {
            "ticket": "<p>No Ticket Found. Please try again!!</p>",
            "ticket_remarks": "<p>No Ticket Remarks Found!</p>"
        }
        return JsonResponse(data)

    # return render(request, 'user/ticket/view.html', {'data': data}) 

def post_reply(request):
    if request.method == "POST":
        ticket_id = request.POST.get('ticket_id')
        ticket = Ticket.objects.get(id=ticket_id)

        tiket_remarks = TicketRemark()
        tiket_remarks.ticket_id = ticket
        tiket_remarks.status_remarks = request.POST.get('comment')
        tiket_remarks.added_by = request.user
        tiket_remarks.save()

        return JsonResponse({
            "sucess": True
        })

def add_ticket_remark(request):
    if request.method == "POST":
        #ticket = Ticket.objects.get(id_)
        #TicketRemark.save()
        pass

@admin_required
def manage_ticket_view_view(request, ticket_id):
    ticket = Ticket.objects.get(id=ticket_id)
    if request.method == 'POST':
        form = TicketRemarksCreationForm(request.POST)
        if form.is_valid():
            remarks = form.save(commit=False)
            remarks.added_by = request.user
            remarks.save()
            if ticket.status == 0:
                ticket.status = 1
                ticket.save()
            messages.success(request, 'Remarks for ticket created successfully!')
            # Redirect back to the same page
            return redirect('admin.manage-ticket.view', ticket_id=remarks.ticket_id.id)
        else:
            messages.success(request, 'Error while adding remarks for ticket!')
    else:
        initial_data = {'status_remarks': ''}
        form = TicketRemarksCreationForm(initial = initial_data)

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'admin/ticket/view.html', {'form': form,'ticket': ticket, "profile": profile})

def generate_ticket_token(length=6):
    characters = string.ascii_uppercase + string.digits
    ticket_token = ''.join(random.choice(characters) for _ in range(length))
    return ticket_token

# ******** Admin view ********
@admin_required
def admin_dashboard_view(request):
    if request.user.is_superuser == True:
        # Calculate counts of total tickets, resolved tickets, and tickets in processing
        total_tickets_count = Ticket.objects.all().count()
        resolved_tickets_count = Ticket.objects.filter(status='2').count()  # Assuming '2' is the status for resolved tickets
        in_processing_tickets_count = Ticket.objects.filter(status='0').count()  # Assuming '1' is the status for tickets in processing
        tickets = Ticket.objects.filter(status = 0).order_by('-created_at')
    else:
        # Calculate counts of total tickets, resolved tickets, and tickets in processing
        total_tickets_count = Ticket.objects.filter(assigned_user=request.user).count()
        resolved_tickets_count = Ticket.objects.filter(assigned_user=request.user, status='2').count()  # Assuming '2' is the status for resolved tickets
        in_processing_tickets_count = Ticket.objects.filter(assigned_user=request.user, status='0').count()  # Assuming '1' is the status for tickets in processing
        tickets = Ticket.objects.filter(assigned_user=request.user, status=0)
    users = User.objects.filter(is_staff = True)
    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    context = {
        'total_tickets_count': total_tickets_count,
        'resolved_tickets_count': resolved_tickets_count,
        'in_processing_tickets_count': in_processing_tickets_count,
        'tickets' : tickets,
        'profile': profile,
    }
    
    return render(request, 'admin/dashboard.html', context)

# Manage Categories
@admin_required
def manage_category_index_view(request):
    # TicketCategory.objects.create(title='Technical Support',description='Technical Support includes Software Bugs, Hardware Issues, Network Problems, Software Installation')
    categories =  TicketCategory.objects.all()

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'admin/category/index.html', {'profile': profile, 'categories': categories})  

@admin_required
def manage_category_create_view(request):
    if request.method == 'POST':
        form = TicketCategoryForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Category created successfully!')
            return redirect('admin.manage-category.index')  
    else:
        initial_data = {'title': '', 'description': ''}
        form = TicketCategoryForm(initial = initial_data)

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None
        
    return render(request, 'admin/category/create.html', {'profile': profile, 'form': form})

@admin_required
def manage_category_edit_view(request, category_id):
    category = get_object_or_404(TicketCategory, pk=category_id)
    if request.method == 'POST':
        form = TicketCategoryForm(request.POST, instance=category)
        if form.is_valid():
            form.save()
            messages.success(request, 'Category updated successfully!')
            return redirect('admin.manage-category.index')  
    else:
        form = TicketCategoryForm(instance=category)

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'admin/category/edit.html', {'profile': profile, 'form': form, 'category': category})

@admin_required
def manage_category_delete_view(request, category_id):
    category = get_object_or_404(TicketCategory, pk=category_id)
    if request.method == 'POST':
        category.delete()
        messages.success(request, 'Category deleted successfully!')
        return redirect('admin.manage-category.index')
    messages.error(request, 'Error! deleting Category!')
    return redirect('admin.manage-category.index')

# Manage Staff 
@admin_required
def manage_staff_index_view(request):
    users = User.objects.filter(is_staff = True)

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'admin/staff/index.html', {'users': users, "profile": profile})  

@admin_required
def manage_staff_create_view(request):
    if request.method == 'POST':
        form  = StaffCreationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.is_staff = True
            user.save()
            messages.success(request, 'Staff Member created successfully!')
            return redirect('admin.manage-staff.index')
    else:
        initial_data = {'first_name': '','last_name': '','username': '','email': '', 'password': ''}
        form = StaffCreationForm(initial = initial_data)

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'admin/staff/create.html', {'form': form, "profile": profile})

@admin_required
def manage_staff_edit_view(request, staff_id):
    staff_member = get_object_or_404(User, id=staff_id, is_staff=True)

    if request.method == 'POST':
        form = StaffCreationForm(request.POST, instance=staff_member)
        if form.is_valid():
            user = form.save(commit=False)
            user.is_staff = True
            user.save()
            messages.success(request, 'Staff Member updated successfully!')
            return redirect('admin.manage-staff.index')
    else:
        form = StaffCreationForm(instance=staff_member)

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'admin/staff/edit.html', {'form': form, 'staff_member': staff_member, "profile": profile})

@admin_required
def manage_staff_change_status_view(request, staff_id):
    staff_member = get_object_or_404(User, id=staff_id, is_staff=True)
    if staff_member.is_active:
        staff_member.is_active = False
        staff_member.save()
        messages.success(request, 'Staff De-Activated Status updated successfully!')
    else:
        staff_member.is_active = True   
        staff_member.save()
        messages.success(request, 'Staff Activated Status updated successfully!')

    return redirect('admin.manage-staff.index')

# Manage Articles
@admin_required
def manage_article_index_view(request):
    if request.user.is_superuser == True:
        articles = Article.objects.all().order_by('-published_date')
    else:
        articles = Article.objects.filter(user_id=request.user).order_by('-published_date')

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'staff/article/index.html', {'articles': articles, "profile": profile})  

@admin_required
def manage_article_create_view(request):
    if request.method == 'POST':
        form = ArticleCreationForm(request.POST)
        if form.is_valid():
            article = form.save(commit=False)
            article.user_id = request.user
            article.views = 0
            article.save()
            messages.success(request, 'Article created successfully!')
            return redirect('admin.manage-article.index') 
        else:
            messages.error(request, 'Found missing fields for article')
            return redirect('admin.manage-article.index') 
    else:
        initial_data = {'title': '', 'description': ''}
        form = ArticleCreationForm(initial = initial_data)

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'staff/article/create.html', {'form': form, "profile": profile})

@admin_required
def manage_article_edit_view(request, article_id):
    article = get_object_or_404(Article, id=article_id)
    
    if request.method == 'POST':
        form = ArticleCreationForm(request.POST, instance=article)
        if form.is_valid():
            form.save()
            messages.success(request, 'Article updated successfully!')
            return redirect('admin.manage-article.index')
    else:
        form = ArticleCreationForm(instance=article)
    
    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'staff/article/edit.html', {'form': form, 'article': article, "profile": profile})

@admin_required
def manage_article_delete_view(request, article_id):
    article = get_object_or_404(Article, id=article_id)
    
    if request.method == 'POST':
        article.delete()
        messages.success(request, 'Article deleted successfully!')
    
    return redirect('admin.manage-article.index')

# Manage FAQs
@admin_required
def manage_faq_index_view(request):
    if request.user.is_superuser == True:
        faqs = FAQ.objects.all().order_by('-created_at')
    else:
        faqs = FAQ.objects.filter(user_id=request.user).order_by('-created_at')
    
    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'staff/faq/index.html', {'faqs': faqs, "profile": profile})  

@admin_required
def manage_faq_create_view(request):
    if request.method == 'POST':
        form = FAQCreationForm(request.POST)
        if form.is_valid():
            faq = form.save(commit=False)
            faq.user_id = request.user
            faq.save()
            messages.success(request, 'FAQ created successfully!')
            return redirect('admin.manage-faq.index') 
        else:
            messages.error(request, 'Found missing fields for FAQ')
            return redirect('admin.manage-faq.index') 
    else:
        initial_data = {'question': '', 'answer': ''}
        form = FAQCreationForm(initial = initial_data)
        
    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'staff/faq/create.html', {'form': form, "profile": profile})

@admin_required
def manage_faq_edit_view(request, faq_id):
    faq = get_object_or_404(FAQ, id=faq_id)
    
    if request.method == 'POST':
        form = FAQCreationForm(request.POST, instance=faq)
        if form.is_valid():
            form.save()
            messages.success(request, 'FAQ updated successfully!')
            return redirect('admin.manage-faq.index')
    else:
        form = FAQCreationForm(instance=faq)
    
    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'staff/faq/edit.html', {'form': form, 'faq': faq, "profile": profile})

@admin_required
def manage_faq_delete_view(request, faq_id):
    faq = get_object_or_404(FAQ, id=faq_id)
    if request.method == 'POST':
        faq.delete()
        messages.success(request, 'FAQ deleted successfully!')
    
    return redirect('admin.manage-faq.index')

# Manage User
@admin_required
def manage_user_index_view(request):
    users = User.objects.filter(is_staff = False)

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'admin/user/index.html' , {'users': users, "profile": profile})

# Manage Ticket
@admin_required
def manage_ticket_index_view(request):
    if request.user.is_superuser == True:
        tickets = Ticket.objects.all().order_by('-created_at')
    else:
        tickets = Ticket.objects.filter(assigned_user=request.user)
    users = User.objects.filter(is_staff = True)

    try:
        profile = Profile.objects.get(user=request.user.id)
    except:
        profile = None

    return render(request, 'admin/ticket/index.html', {'tickets': tickets, 'users': users, "profile": profile}) 

@admin_required
def manage_ticket_assign_view(request, ticket_id):
    if request.method == 'POST':
        assigned_user_id = request.POST.get('assigned_user_id')
        try:
            ticket = Ticket.objects.get(id=ticket_id)
            user = User.objects.get(id=assigned_user_id)
            ticket.assigned_user = user
            ticket.is_assigned = True
            ticket.save()
            messages.success(request, f'Ticket assigned to {user.username} successfully!')
            return redirect('admin.manage-ticket.index')
        except Ticket.DoesNotExist:
            messages.error(request, 'Ticket does not exist!')
        except User.DoesNotExist:
            messages.error(request, 'User does not exist!')
    return redirect('admin.manage-ticket.index')

@admin_required
def manage_ticket_resolved_view(request, ticket_id):
    ticket = Ticket.objects.get(id=ticket_id)
    ticket.status = 2
    ticket.save()
    messages.success(request, f'Ticket mark as resolved successfully!')

    return redirect('admin.manage-ticket.index')
