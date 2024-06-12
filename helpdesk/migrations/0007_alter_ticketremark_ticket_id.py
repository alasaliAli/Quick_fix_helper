# Generated by Django 5.0.1 on 2024-02-02 10:55

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('helpdesk', '0006_rename_create_at_ticket_created_at_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='ticketremark',
            name='ticket_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='ticket_remarks', to='helpdesk.ticket'),
        ),
    ]
