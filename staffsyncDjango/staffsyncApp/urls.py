from django.urls import path
from . import views

urlpatterns = [
    path('', views.login_view, name='staffsync-login' ),
    path('hr/', views.hr_home, name='hr-home'),
    path('employee/', views.employee_home, name='employee-home'),
    path('dependents/', views.view_dependents, name='employee-dependent'),
    path('emergencycontact/', views.view_emergency_contacts, name='employee-emergencycontact'),
    path('add-dependent/', views.add_dependent, name='employee-add-dependent'),
    path('employee/update-dependent/<int:dependent_id>/', views.update_dependent, name='employee-update-dependent'),
    path('delete-dependent/<int:dependent_id>/', views.delete_dependent, name='employee-delete-dependent'),
    path('admin_home/', views.admin_home, name='admin-home'),
    path('add-emergency-contact/', views.add_emergency_contact, name='add-emergency-contact'),
    path('update-emergency-contact/<int:contact_id>/', views.update_emergency_contact, name='update-emergency-contact'),
    path('delete-emergency-contact/<int:contact_id>/', views.delete_emergency_contact, name='delete-emergency-contact'),
    path('apply-for-leave/', views.log_leave, name='apply-for-leave'),
    path('view-leave/', views.view_employee_leaves, name='view-leave'),



]