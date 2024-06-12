from django.db import models
from django.contrib.auth.models import User
from django.conf import settings

class TicketCategory(models.Model):
    title = models.CharField(max_length=100)
    description = models.TextField()

# Ticket Model
class Ticket(models.Model):
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    ticket_token = models.CharField(max_length=6)
    subject = models.CharField(max_length=255)
    description = models.TextField()
    PROGRESS_STATUS = {
        "0": "Pending",
        "1": "Processing",
        "2": "Resolved",
    }
    status = models.CharField(max_length=1, choices=PROGRESS_STATUS)
    # category = models.ForeignKey(models.ForeignKey)
    assigned_user = models.ForeignKey(
        User,
        on_delete = models.CASCADE,
        related_name='assigned_tickets',
        null=True,  # Allow null values if needed
        blank=True,
    )
    is_assigned = models.BooleanField(default=False)
    priority = models.CharField(max_length=50, default='Normal')  # Example default value
    category_id = models.ForeignKey(
        TicketCategory,
        on_delete=models.CASCADE,
        null=True,  # Allow null values if needed
        blank=True,
    )
    created_at = models.DateTimeField(auto_now_add=True,null=True,  # Allow null values if needed
        blank=True,)


# Assign Ticket Model
class TicketAttachment(models.Model):
    ticket_id = models.ForeignKey(Ticket, on_delete=models.CASCADE)
    # Define the relative path from MEDIA_ROOT
    file = models.FileField(upload_to='attachments/')
    file_type = models.CharField(max_length=100)

class TicketRemark(models.Model):
    ticket_id = models.ForeignKey(Ticket, on_delete=models.CASCADE, related_name='ticket_remarks')
    status_remarks = models.TextField()
    added_by = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

class FAQ(models.Model):
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    question = models.TextField()
    answer = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

class Article(models.Model):
    user_id = models.ForeignKey(User, on_delete=models.CASCADE, related_name='articles')
    title = models.CharField(max_length=255)
    description = models.TextField()
    published_date = models.DateTimeField(auto_now_add=True)
    views = models.IntegerField(default=0)

class Contact(models.Model):
    name = models.CharField(max_length=255)
    message = models.TextField()
    subject = models.TextField()
    email = models.CharField(max_length=255)

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='user_profile')
    image = models.ImageField(upload_to='faces/', default='face.jpg')

    def __str__(self):
        return self.user.username

