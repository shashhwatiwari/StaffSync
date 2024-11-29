from django.contrib import admin

# Register your models here.

from .models import *

admin.site.register(Department)
# admin.site.register(AuditLog)
class EmployeeAdmin(admin.ModelAdmin):
    # Specify all the fields you want to display in the list view
    list_display = (
        'employeeid', 'employeename', 'dateofbirth', 'gender', 'maritalstatus',
        'address', 'country', 'organizationid', 'departmentid', 'jobtitleid', 'paygradeid', 'supervisorid'
    )

    # Optionally, add the ability to search by employeename and other fields
    search_fields = ('employeename', 'employeeid', 'address', 'country')

    # Optionally, you can add filters for the admin sidebar
    list_filter = ('gender', 'maritalstatus', 'country', 'departmentid')

    # Pagination for large sets of records
    list_per_page = 20
admin.site.register(Employee, EmployeeAdmin)
class DependentinfoAdmin(admin.ModelAdmin):
    list_display = ('dependentinfoid','employeeid','dependentname','dependentage')
    search_fields = ('dependentname','dependentinfoid')
    list_per_page = 20
admin.site.register(Dependentinfo,DependentinfoAdmin)
admin.site.register(EmergencyContact)
admin.site.register(Jobtitle)
admin.site.register(LeaveTracker)
admin.site.register(Organization)
admin.site.register(Paygrade)
admin.site.register(Useraccount)
admin.site.register(Auditlog)
