# forms.py
from django import forms
from .models import TicketCategory, Article, FAQ, Ticket, TicketRemark, Contact, Profile
from django.contrib.auth.models import User
from django.core.validators import RegexValidator 
from django.core.exceptions import ValidationError
from django.contrib.auth.forms import UserCreationForm

class ProfileForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['image'].widget = forms.widgets.FileInput(
            attrs={
                'id': 'image',
                'class': 'd-none',
                'accept': "image/jpeg, image/png, image/jpg"
                }
            )
        self.fields['image'].required = False
        self.fields['image'].label = False
        self.fields['user'].required = False
        self.fields['user'].widget = forms.widgets.HiddenInput(
            attrs={
                'class': 'd-none',
                },
            )
    class Meta:
        model = Profile
        fields = '__all__'

class TicketCategoryForm(forms.ModelForm):
    class Meta:
        model = TicketCategory
        fields = ['title', 'description']

# Staff        
class StaffCreationForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email','username', 'is_staff']

    def __init__(self, *args, **kwargs):
        super(StaffCreationForm, self).__init__(*args, **kwargs)
        self.fields['first_name'].required = True
        self.fields['last_name'].required = True
        self.fields['email'].required = True

    def clean_email(self):
        email = self.cleaned_data.get('email')
        existing_user = User.objects.exclude(pk=self.instance.pk).filter(email=email)
        if existing_user.exists():
            raise forms.ValidationError("This email address is already in use.")
        return email

    def clean_username(self):
        username = self.cleaned_data.get('username')
        existing_user = User.objects.exclude(pk=self.instance.pk).filter(username=username)
        if existing_user.exists():
            raise forms.ValidationError("A user with that username already exists.")
        return username

    def clean_first_name(self):
        first_name = self.cleaned_data.get('first_name')
        validator = RegexValidator(
            regex=r'^[a-zA-Z_]+$',
            message='First name must contain only letters and underscores.',
            code='invalid_first_name'
        )
        validator(first_name)
        return first_name

    def clean_last_name(self):
        last_name = self.cleaned_data.get('last_name')
        validator = RegexValidator(
            regex=r'^[a-zA-Z_]+$',
            message='Last name must contain only letters and underscores.',
            code='invalid_last_name'
        )
        validator(last_name)
        return last_name#  Article 
class ArticleCreationForm(forms.ModelForm):
    class Meta:
        model = Article
        fields = ['title', 'description']
    def __init__(self, *args, **kwargs):
        super(ArticleCreationForm, self).__init__(*args, **kwargs)
        self.fields['title'].required = True
        self.fields['description'].required = True

#  Article 
class FAQCreationForm(forms.ModelForm):
    class Meta:
        model = FAQ
        fields = ['question', 'answer']
    def __init__(self, *args, **kwargs):
        super(FAQCreationForm, self).__init__(*args, **kwargs)
        self.fields['question'].required = True
        self.fields['answer'].required = True

# Ticket 
class TicketCreationForm(forms.ModelForm):
    class Meta:
        model = Ticket
        fields = ['subject', 'description', 'priority', 'category_id']

# Ticket Remarks
class TicketRemarksCreationForm(forms.ModelForm):
    class Meta:
        model = TicketRemark
        fields = ['status_remarks','ticket_id']   

# Contact
class ContactCreationForm(forms.ModelForm):
    class Meta:
        model = Contact
        fields = ['name','message', 'subject', 'email']     

# register 
class CustomUserCreationForm(UserCreationForm):
    email = forms.EmailField(max_length=254, help_text='Required. Enter a valid email address.')

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']        