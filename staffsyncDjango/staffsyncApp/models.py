# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Auditlog(models.Model):
    logid = models.AutoField(db_column='LogID', primary_key=True)  # Field name made lowercase.
    action = models.CharField(db_column='Action', max_length=50, blank=True, null=True)  # Field name made lowercase.
    tablename = models.CharField(db_column='TableName', max_length=50, blank=True, null=True)  # Field name made lowercase.
    recordid = models.CharField(db_column='RecordID', max_length=20, blank=True, null=True)  # Field name made lowercase.
    timestamp = models.DateTimeField(db_column='Timestamp', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'AuditLog'


class Department(models.Model):
    departmentid = models.IntegerField(db_column='DepartmentID', primary_key=True)  # Field name made lowercase.
    departmentname = models.CharField(db_column='DepartmentName', max_length=50)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Department'

    def __str__(self):
        return self.departmentname


class Dependentinfo(models.Model):
    dependentinfoid = models.AutoField(db_column='DependentInfoID', primary_key=True)  # Field name made lowercase.
    employeeid = models.ForeignKey('Employee', models.DO_NOTHING, db_column='EmployeeID')  # Field name made lowercase.
    dependentname = models.CharField(db_column='DependentName', max_length=100, blank=True, null=True)  # Field name made lowercase.
    dependentage = models.IntegerField(db_column='DependentAge')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'DependentInfo'


class Employee(models.Model):
    employeeid = models.AutoField(db_column='EmployeeID', primary_key=True)  # Field name made lowercase.
    employeename = models.CharField(db_column='EmployeeName', max_length=100)  # Field name made lowercase.
    dateofbirth = models.DateField(db_column='DateOfBirth', blank=True, null=True)  # Field name made lowercase.
    gender = models.CharField(db_column='Gender', max_length=17, blank=True, null=True)  # Field name made lowercase.
    maritalstatus = models.CharField(db_column='MaritalStatus', max_length=9, blank=True, null=True)  # Field name made lowercase.
    address = models.CharField(db_column='Address', max_length=200, blank=True, null=True)  # Field name made lowercase.
    country = models.CharField(db_column='Country', max_length=50, blank=True, null=True)  # Field name made lowercase.
    organizationid = models.ForeignKey('Organization', models.DO_NOTHING, db_column='OrganizationID', blank=True, null=True)  # Field name made lowercase.
    departmentid = models.ForeignKey(Department, models.DO_NOTHING, db_column='DepartmentID', blank=True, null=True)  # Field name made lowercase.
    jobtitleid = models.ForeignKey('Jobtitle', models.DO_NOTHING, db_column='JobTitleID', blank=True, null=True)  # Field name made lowercase.
    paygradeid = models.ForeignKey('Paygrade', models.DO_NOTHING, db_column='PayGradeID', blank=True, null=True)  # Field name made lowercase.
    supervisorid = models.ForeignKey('self', models.DO_NOTHING, db_column='SupervisorID', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Employee'

    def __str__(self):
        return self.employeename


class EmergencyContact(models.Model):
    emergencycontactid = models.AutoField(db_column='EmergencyContactID', primary_key=True)
    employeeid = models.ForeignKey(Employee, on_delete=models.CASCADE, db_column='EmployeeID')
    contactname = models.CharField(db_column='ContactName', max_length=100, blank=True, null=True)
    phonenumber = models.CharField(db_column='PhoneNumber', max_length=20, blank=True, null=True)
    address = models.CharField(db_column='Address', max_length=200, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'EmergencyContact'


class Jobtitle(models.Model):
    jobtitleid = models.AutoField(db_column='JobTitleID', primary_key=True)  # Field name made lowercase.
    jobtitlename = models.CharField(db_column='JobTitleName', max_length=50)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'JobTitle'

    def __str__(self):
        return self.jobtitlename


class LeaveTracker(models.Model):
    leaveid = models.AutoField(db_column='LeaveID', primary_key=True)  # Field name made lowercase.
    leavelogdatetime = models.DateTimeField(db_column='LeaveLogDateTime', blank=True, null=True)  # Field name made lowercase.
    employeeid = models.ForeignKey(Employee, models.DO_NOTHING, db_column='EmployeeID')  # Field name made lowercase.
    approved = models.IntegerField(db_column='Approved', blank=True, null=True)  # Field name made lowercase.
    reason = models.CharField(db_column='Reason', max_length=255, blank=True, null=True)  # Field name made lowercase.
    leavetype = models.CharField(db_column='LeaveType', max_length=9, blank=True, null=True)  # Field name made lowercase.
    firstabsentdate = models.DateField(db_column='FirstAbsentDate', blank=True, null=True)  # Field name made lowercase.
    lastabsentdate = models.DateField(db_column='LastAbsentDate', blank=True, null=True)  # Field name made lowercase.
    leavedaycount = models.IntegerField(db_column='LeaveDayCount', blank=True, null=True)  # Field name made lowercase.
    approveddatetime = models.DateTimeField(db_column='ApprovedDateTime', blank=True, null=True)  # Field name made lowercase.
    approvedbyid = models.ForeignKey(Employee, models.DO_NOTHING, db_column='ApprovedByID', related_name='leavetracker_approvedbyid_set', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Leave_tracker'


class Organization(models.Model):
    organizationid = models.AutoField(db_column='OrganizationID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=50)  # Field name made lowercase.
    address = models.CharField(db_column='Address', max_length=100)  # Field name made lowercase.
    registrationnumber = models.CharField(db_column='RegistrationNumber', max_length=20)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Organization'

    def __str__(self):
        return self.name


class Paygrade(models.Model):
    paygradeid = models.AutoField(db_column='PayGradeID', primary_key=True)  # Field name made lowercase.
    paygradename = models.CharField(db_column='PayGradeName', max_length=50)  # Field name made lowercase.
    annualleavecount = models.IntegerField(db_column='AnnualLeaveCount')  # Field name made lowercase.
    casualleavecount = models.IntegerField(db_column='CasualLeaveCount')  # Field name made lowercase.
    maternityleavecount = models.IntegerField(db_column='MaternityLeaveCount')  # Field name made lowercase.
    payleavecount = models.IntegerField(db_column='PayLeaveCount')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'PayGrade'


class Useraccount(models.Model):
    userid = models.AutoField(db_column='UserID', primary_key=True)  # Field name made lowercase.
    username = models.CharField(db_column='Username', unique=True, max_length=50)  # Field name made lowercase.
    email = models.CharField(db_column='Email', unique=True, max_length=100)  # Field name made lowercase.
    passwordhash = models.CharField(db_column='PasswordHash', max_length=255)  # Field name made lowercase.
    employeeid = models.ForeignKey(Employee, models.DO_NOTHING, db_column='EmployeeID')  # Field name made lowercase.
    user_role = models.CharField(db_column='User_Role', max_length=7)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'UserAccount'

    def __str__(self):
        return self.username

class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'
