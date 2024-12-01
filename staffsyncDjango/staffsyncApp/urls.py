from django.urls import path
from . import views

urlpatterns = [
    path('', views.login_view, name='staffsync-login' ),
    path('hr/', views.hr_home, name='hr-home'),
    path('update-employee/', views.update_employeeHR, name='update_employee'),

    path('employee/', views.employee_home, name='employee-home'),
    path('dependents/', views.view_dependents, name='employee-dependent'),
    path('emergencycontact/', views.view_emergency_contacts, name='employee-emergencycontact'),
    path('add-dependent/', views.add_dependent, name='employee-add-dependent'),
    path('employee/update-dependent/<int:dependent_id>/', views.update_dependent, name='employee-update-dependent'),
    path('delete-dependent/<int:dependent_id>/', views.delete_dependent, name='employee-delete-dependent'),
    path('add-emergency-contact/', views.add_emergency_contact, name='add-emergency-contact'),
    path('update-emergency-contact/<int:contact_id>/', views.update_emergency_contact, name='update-emergency-contact'),
    path('delete-emergency-contact/<int:contact_id>/', views.delete_emergency_contact, name='delete-emergency-contact'),
    path('apply-for-leave/', views.log_leave, name='apply-for-leave'),
    path('view-leave/', views.view_employee_leaves, name='view-leave'),


    path('admin_home/', views.admin_home, name='admin-home'),
    path('employee-list/', views.employee_list, name='employee_list'),
    path('edit_employee/<int:employee_id>/', views.edit_employee, name='edit-employee'),
    path('delete_employee/<int:employee_id>/', views.delete_employee, name='employee-delete'),
    path('add_employee/', views.add_employee, name='add-employee'),

    path('department_list/', views.department_list, name='department_list'),
    path('edit_department/<int:department_id>/', views.edit_department, name='edit_department'),
    path('delete_department/<int:department_id>/', views.delete_department, name='delete_department'),
    path('add_department/', views.add_department, name='add_department'),

]