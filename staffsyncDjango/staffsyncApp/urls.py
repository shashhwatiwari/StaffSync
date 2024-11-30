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
    path('modify_employee/', views.modify_employee, name='modify-employee'),
    path('edit_employee/<int:employee_id>/', views.edit_employee, name='edit-employee'),
    # path('delete-employee/<int:employee_id>/', views.delete_employee, name='employee-delete'),

]