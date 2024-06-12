from django.urls import path, include
from . import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    # ******* Frontend *******
    path('', views.index_view, name='index'),
    path('frequently-asked-questions', views.faq_view, name='faq'),
    path('contact', views.contact_view, name='contact'),
    path('articles', views.articles_view, name='articles'),

    path('login', views.login_view, name='login'),
    path('register', views.register_view, name='register'),
    path('logout', views.logout_view, name='logout'),

    # ****** User URL ******
    path('user/dashboard', views.dashboard_view, name='user.dashboard'),
    path('user/create-ticket', views.create_ticket_view, name='user.create.ticket'),
    path('user/view-ticket', views.user_view_ticket_view, name='user.view.ticket'),
    path('user/track-ticket/post-reply', views.post_reply, name="user-post-reply"),
    path('user/track-ticket/<str:token>', views.search_ticket_view, name='user.search.ticket'),

    # ****** Admin URL ******
    path("admin/", include(
        [
            path('dashboard', views.admin_dashboard_view, name='admin.dashboard'),

            path('manage-category/', include([
                path('', views.manage_category_index_view, name='admin.manage-category.index'),
                path('create', views.manage_category_create_view, name='admin.manage-category.create'),
                path('edit/<int:category_id>', views.manage_category_edit_view, name='admin.manage-category.edit'),
                path('delete/<int:category_id>', views.manage_category_delete_view, name='admin.manage-category.delete'),
            ])),
            path('manage-feedback/', include([
                path('', views.manage_contact_index_view ,name='admin.manage-feedback.index'),
                path('delete/<int:feedback_id>', views.manage_contact_delete_view, name='admin.manage-contact.delete'),
            ])),
            path('manage-staff/', include([
                path('', views.manage_staff_index_view, name='admin.manage-staff.index'),
                path('create', views.manage_staff_create_view, name='admin.manage-staff.create'),
                path('edit/<int:staff_id>', views.manage_staff_edit_view, name='admin.manage-staff.edit'),
                path('change-active-status/<int:staff_id>', views.manage_staff_change_status_view, name='admin.manage-staff.change-status'),
            ])),
            path('manage-article/', include([
                path('', views.manage_article_index_view, name='admin.manage-article.index'),
                path('create', views.manage_article_create_view, name='admin.manage-article.create'),
                path('edit/<int:article_id>', views.manage_article_edit_view, name='admin.manage-article.edit'),
                path('delete/<int:article_id>', views.manage_article_delete_view, name='admin.manage-article.delete'),
            ])),
            path('manage-faq/', include([
                path('', views.manage_faq_index_view, name='admin.manage-faq.index'),
                path('create', views.manage_faq_create_view, name='admin.manage-faq.create'),
                path('edit/<int:faq_id>', views.manage_faq_edit_view, name='admin.manage-faq.edit'),
                path('delete/<int:faq_id>', views.manage_faq_delete_view, name='admin.manage-faq.delete'),
            ])),
            path('manage-user/', views.manage_user_index_view, name='admin.manage-user.index'),
            
            path('profile/', views.admin_profile, name='admin.admin-prodile.index'),
            path('user-profile/', views.admin_profile, name='user.user-prodile.index'),

            path("manage-ticket/", include([
                path('', views.manage_ticket_index_view, name='admin.manage-ticket.index'),
                path('view-ticket/<int:ticket_id>', views.manage_ticket_view_view, name='admin.manage-ticket.view'),
                path('assign-ticket/<int:ticket_id>', views.manage_ticket_assign_view, name='admin.manage-ticket.assign-user'),
                path('resolved-ticket/<int:ticket_id>', views.manage_ticket_resolved_view, name='admin.manage-ticket.resolved-ticket'),
            ])),
        ]
        )
    ),

    # ****** Staff URL ******
    path('staff/dashboard', views.dashboard_view, name='staff.dashboard'),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)