from django.contrib.auth import logout
from django.contrib.auth.hashers import make_password
from django.shortcuts import render, redirect
from .db_utils import execute_query, call_procedure, OutParam
from django.contrib import messages

#from .models import Employee


# login method
def login_view(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        print(f"Login attempt: username={username}, password={password}")  # Debug print

        query = "SELECT * FROM UserAccount WHERE Username = %s AND PasswordHash = %s"
        user_data = execute_query(query, [username, password])
        print(f"User data: {user_data}")  # Debug print

        if user_data:
            user = user_data[0]
            request.session['user_id'] = user['UserID']
            request.session['user_role'] = user['User_Role']
            request.session['emp_id'] = user['EmployeeID']

            if user['User_Role'] == 'HR':
                print("Redirecting to HR home")  # Debug print
                return redirect('hr-home')
            elif user['User_Role'] == 'Admin':
                print("Redirecting to ADMIN home")
                return redirect('admin-home')
            else:
                print("Redirecting to employee home")  # Debug print
                return redirect('employee-home')
        else:
            print("Authentication failed")  # Debug print
            # Pass error message to the template
            return render(request, 'login.html', {'error': 'Invalid username or password.'})

    # Render the login page without error for GET requests
    return render(request, 'login.html')


# method for HR page
def hr_home(request):
    if request.session.get('user_role') != 'HR':
        return redirect('login')

    logged_in_user_emp_id = request.session.get('emp_id')

    # retrieving the organization data for the logged in employee so that they are only able
    # to see employees working for their organization

    org_query = "SELECT OrganizationID FROM Employee WHERE EmployeeID = %s"
    org_result = execute_query(org_query, [logged_in_user_emp_id])
    organization_id = org_result[0]['OrganizationID'] if org_result else None

    # getting the employee data and filtering out the currently logged-in user details
    # since they should not be allowed to update their own JobTitles, Supervisors, or PayGrades

    employee_query = """
    SELECT EmployeeID, EmployeeName, DateOfBirth, DepartmentID, JobTitleID, PayGradeID, SupervisorID
    FROM Employee
    WHERE EmployeeID != %s AND OrganizationID = %s
    """
    employees = execute_query(employee_query, [logged_in_user_emp_id, organization_id])

    # getting the data to show in the drop-down filters while updating employee information for better readability
    job_titles = execute_query(
        "SELECT JobTitleID, CONCAT(JobTitleID, ': ', JobTitleName) AS JobTitleLabel FROM JobTitle")
    pay_grades = execute_query(
        "SELECT PayGradeID, CONCAT(PayGradeID, ': ', PayGradeName) AS PayGradeLabel FROM PayGrade")

    supervisors = execute_query(
        """
        SELECT NULL AS EmployeeID, 'None' AS EmployeeLabel
        UNION ALL
        SELECT EmployeeID, CONCAT(EmployeeID, ': ', EmployeeName) AS EmployeeLabel
        FROM Employee
        WHERE OrganizationID = %s
        """,
        [organization_id]
    )

    departments = execute_query(
        "SELECT DepartmentID, CONCAT(DepartmentID, ': ', DepartmentName) AS DepartmentLabel FROM Department"
    )
    context = {
        'employees': employees,
        'job_titles': job_titles,
        'pay_grades': pay_grades,
        'supervisors': supervisors,
        'departments': departments
    }
    return render(request, 'hr-home.html', context)


# Method for Regular Employees
def employee_home(request):
    if 'user_id' not in request.session:
        return redirect('login')

    user_id = request.session['emp_id']

    try:
        # Fetch employee's own data
        employee_data = call_procedure('GetEmployeeDetails', [user_id])
        if employee_data:
            employee = employee_data[0]
        else:
            messages.error(request, "No employee data found.")
            return redirect('login')
    except Exception as e:
        messages.error(request, f"Error fetching employee data: {str(e)}")
        return redirect('login')

    return render(request, 'employee-home.html', {'employee': employee})

    return render(request, 'employee-home.html',
                  {'employee': employee_data[0] if employee_data else None})


# -------------------------------------------------------------------------------------------------------------------------------------------------
# CRUD Methods for Employee Dependents

# Method to view employee dependents
def view_dependents(request):
    if 'user_id' not in request.session:
        return redirect('login')

    user_id = request.session['emp_id']
    dependents = call_procedure('get_employee_dependents', [user_id])
    print("Dependents:", dependents)
    return render(request, 'view_dependents.html', {'dependents': dependents})


# Method to add new dependents
def add_dependent(request):
    if request.method == 'POST':
        employee_id = request.session['emp_id']
        if not employee_id:
            messages.error(request, 'User not authenticated.')
            return redirect('login')

        dependent_name = request.POST.get('dependent_name')
        dependent_age = request.POST.get('dependent_age')

        if not dependent_name or not dependent_age:
            messages.error(request, 'Please provide both name and age for the dependent.')
            return render(request, 'add_dependent.html')

        try:
            dependent_age = int(dependent_age)
        except ValueError:
            messages.error(request, 'Age must be a valid number.')
            return render(request, 'add_dependent.html')

        out_param = OutParam()

        try:
            call_procedure('insert_dependent', [employee_id, dependent_name, dependent_age, out_param])
            return redirect('employee-dependent')

        except Exception as e:
            messages.error(request, f'Error adding dependent: {str(e)}')

    return render(request, 'add_dependent.html')


# Method to update a dependent
def update_dependent(request, dependent_id):
    if request.method == 'POST':
        dependent_name = request.POST.get('dependentName')
        dependent_age = request.POST.get('dependentAge')

        try:
            call_procedure('update_dependent', [dependent_id, dependent_name, dependent_age])

        except Exception as e:
            messages.error(request, f'Error updating dependent: {str(e)}')

        return redirect('employee-dependent')

    # If it's a GET request, you might want to return an error or redirect
    return redirect('employee-dependent')


# Method to delete a dependent
def delete_dependent(request, dependent_id):
    if request.method == 'POST':
        try:
            call_procedure('delete_dependent', [dependent_id])
            # messages.success(request, 'Dependent deleted successfully.')
        except Exception as e:
            messages.error(request, f'Error deleting dependent: {str(e)}')
    return redirect('employee-dependent')


# -------------------------------------------------------------------------------------------------------------------------------------------------
# CRUD Methods for Emergency Contacts

# Method to view employee emergency contacts
def view_emergency_contacts(request):
    if 'user_id' not in request.session:
        return redirect('login')

    user_id = request.session['emp_id']
    contacts = call_procedure('get_employee_emergency_contacts', [user_id])
    return render(request, 'view_emergency_contacts.html', {'contacts': contacts})


# Method to add an employees emergency contact
def add_emergency_contact(request):
    if request.method == 'POST':
        employee_id = request.session.get('emp_id')
        contact_name = request.POST.get('contact_name')
        phone_number = request.POST.get('phone_number')
        address = request.POST.get('address')

        out_param = OutParam()
        try:
            call_procedure('insert_emergency_contact',
                           [employee_id, contact_name, phone_number, address, out_param])
        except Exception as e:
            messages.error(request, f'Error adding emergency contact: {str(e)}')
        return redirect('employee-emergencycontact')

    return render(request, 'add_emergency_contact.html')


# Method to update an emergency contact
def update_emergency_contact(request, contact_id):
    if request.method == 'POST':
        contact_name = request.POST.get('contact_name')
        phone_number = request.POST.get('phone_number')
        address = request.POST.get('address')

        try:
            call_procedure('update_emergency_contact',
                           [contact_id, contact_name, phone_number, address])
        except Exception as e:
            messages.error(request, f'Error updating emergency contact: {str(e)}')

        return redirect('employee-emergencycontact')

    # For GET requests, you might want to fetch the current contact info and render a form
    contact = call_procedure('get_employee_emergency_contacts', [request.session.get('user_id')])
    contact = next((c for c in contact if c['EmergencyContactID'] == contact_id), None)
    return render(request, 'update_emergency_contact.html', {'contact': contact})


# Method to delete emergency contact for an employee
def delete_emergency_contact(request, contact_id):
    if request.method == 'POST':
        try:
            call_procedure('delete_emergency_contact', [contact_id])
        except Exception as e:
            messages.error(request, f'Error deleting emergency contact: {str(e)}')

    return redirect('employee-emergencycontact')


# -------------------------------------------------------------------------------------------------------------------------------------------------

# Method to log a leave

def log_leave(request):
    if request.method == 'POST':
        employee_id = request.session.get('emp_id')
        reason = request.POST.get('reason')
        leave_type = request.POST.get('leave_type')
        first_absent_date = request.POST.get('first_absent_date')
        last_absent_date = request.POST.get('last_absent_date')
        out_param = OutParam()
        try:
            call_procedure('LogLeave', [
                employee_id,
                reason,
                leave_type,
                first_absent_date,
                last_absent_date,
                out_param
            ])
            return redirect('employee-home')
        except Exception as e:
            messages.error(request, f'Error submitting leave request: {str(e)}')
    return render(request, 'log_leave.html')


# Method to view leaves logged by an employee.
def view_employee_leaves(request):
    if 'user_id' not in request.session:
        return redirect('login')

    employee_id = request.session['emp_id']

    try:
        leaves = call_procedure('get_employee_leaves', [employee_id])
        return render(request, 'view_leaves.html', {'leaves': leaves})
    except Exception as e:
        messages.error(request, f'Error retrieving leave data: {str(e)}')
        return redirect('employee_dashboard')


# -------------------------------------------------------------------------------------------------------------------------------------------------
# HR Update method for modifying an employee's PayGrade, Supervisor, JobTitle

def update_employeeHR(request):
    if request.method == 'POST':
        employee_id = request.POST.get('employee_id')
        job_title_id = request.POST.get('job_title_id')
        pay_grade_id = request.POST.get('pay_grade_id')
        supervisor_id = request.POST.get('supervisor_id')
        department_id = request.POST.get('department_id')

        # Convert 'None' string to None (NULL in SQL)
        if supervisor_id == 'None' or supervisor_id == '':
            supervisor_id = None
        else:
            supervisor_id = int(supervisor_id)

        # Check if supervisor_id is the same as employee_id
        if supervisor_id == int(employee_id):
            messages.error(request, 'An employee cannot be their own supervisor.')
            return redirect('hr-home')

        # Fetch current employee data
        employee_query = "SELECT * FROM Employee WHERE EmployeeID = %s"
        employee_data = execute_query(employee_query, [employee_id])[0]

        try:
            call_procedure('update_employee', [
                employee_id,
                employee_data['EmployeeName'],
                employee_data['DateOfBirth'],
                employee_data['Gender'],
                employee_data['MaritalStatus'],
                employee_data['Address'],
                employee_data['Country'],
                employee_data['OrganizationID'],
                department_id,
                job_title_id,
                pay_grade_id,
                supervisor_id,
                employee_data['NumberOfLeaves']
            ])
            # messages.success(request, 'Employee updated successfully.')
        except Exception as e:
            messages.error(request, f'Error updating employee: {str(e)}')

    return redirect('hr-home')


# method to view the audit logs:
def admin_home(request):
    if 'user_id' not in request.session:
        return redirect('login')
    query = "SELECT * FROM AuditLog ORDER BY Timestamp DESC"  # You can add filtering or sorting as needed
    auditlogs = execute_query(query)  # Assuming `execute_query` returns a list of rows

    return render(request, 'admin-home.html', {'auditlogs': auditlogs})


# -------------------------------------------------------------------------------------------------------------------------------------------------
# Methods for CRUD Functionality for the Admin view.


# Method to show the list of employees in the database currently when we click the modify employee button.
def employee_list(request):
    # Query to fetch all employees
    employee_query = """
    SELECT EmployeeID, EmployeeName, DepartmentID, JobTitleID, PayGradeID
    FROM Employee
    """
    employees = execute_query(employee_query)

    context = {
        'employees': employees
    }
    return render(request, 'employee_list.html', context)


# Method to edit the employee details.
def edit_employee(request, employee_id):
    if request.method == 'POST':
        # Fetch current employee data
        current_employee_data = call_procedure('EmployeeDetailsByID', [employee_id])[0]

        # Prepare updated data, only including changed fields
        updated_data = {
            'EmployeeID': employee_id,
            'EmployeeName': current_employee_data['EmployeeName'],
            'Address': request.POST.get('address', current_employee_data['Address']),
            'Country': current_employee_data['Country'],
            'DateOfBirth': current_employee_data['DateOfBirth'],
            'Gender': request.POST.get('gender', current_employee_data['Gender']),
            'MaritalStatus': request.POST.get('Maritalstatus', current_employee_data['MaritalStatus']),
            'DepartmentID': request.POST.get('Departmentid', current_employee_data['DepartmentID']),
            'JobTitleID': request.POST.get('Jobtitleid', current_employee_data['JobTitleID']),
            'PayGradeID': request.POST.get('Paygradeid', current_employee_data['PayGradeID']),
            'OrganizationID': request.POST.get('Organizationid', current_employee_data['OrganizationID']),
            'SupervisorID': request.POST.get('Supervisorid', current_employee_data['SupervisorID']),
            'NumberOfLeaves': request.POST.get('number_of_leaves', current_employee_data['NumberOfLeaves'])
        }

        # Filter out unchanged fields
        updated_fields = {k: v for k, v in updated_data.items() if str(v) != str(current_employee_data.get(k))}

        if updated_fields:
            try:
                # Prepare the UPDATE query
                set_clause = ', '.join([f"{k} = %s" for k in updated_fields.keys()])
                query = f"UPDATE Employee SET {set_clause} WHERE EmployeeID = %s"
                params = list(updated_fields.values()) + [employee_id]

                # Execute the UPDATE query
                execute_query(query, params)
                messages.success(request, 'Employee updated successfully.')
            except Exception as e:
                messages.error(request, f'Error updating employee: {str(e)}')
        else:
            messages.info(request, 'No changes were made.')

        return redirect('employee_list')

    # Fetch employee details for GET request
    employee_details = call_procedure('EmployeeDetailsByID', [employee_id])[0]

    # Fetch additional data for dropdowns
    departments = execute_query(
        "SELECT DepartmentID, CONCAT(DepartmentID, ': ', DepartmentName) AS DepartmentLabel FROM Department")
    job_titles = execute_query(
        "SELECT JobTitleID, CONCAT(JobTitleID, ': ', JobTitleName) AS JobTitleLabel FROM JobTitle")
    pay_grades = execute_query(
        "SELECT PayGradeID, CONCAT(PayGradeID, ': ', PayGradeName) AS PayGradeLabel FROM PayGrade")
    organizations = execute_query(
        "SELECT OrganizationID, CONCAT(OrganizationID, ': ', Name) AS OrganizationLabel FROM Organization")
    supervisors = execute_query("""
        SELECT NULL AS EmployeeID, 'None' AS EmployeeLabel
        UNION ALL
        SELECT EmployeeID, CONCAT(EmployeeID, ': ', EmployeeName) AS EmployeeLabel
        FROM Employee
        WHERE EmployeeID != %s
    """, [employee_id])

    context = {
        'employee': employee_details,
        'departments': departments,
        'job_titles': job_titles,
        'pay_grades': pay_grades,
        'organizations': organizations,
        'supervisors': supervisors
    }

    return render(request, 'edit_employee.html', context)


# method to delete employee
def delete_employee(request, employee_id):
    if request.method == 'POST':
        try:
            # Delete the employee using Django ORM, which will trigger the before_employee_delete trigger
            call_procedure('delete_employee', [employee_id])  # The trigger will automatically be called here

            # Optionally, you can add a success message
            messages.success(request, 'Employee deleted successfully.')
        except Exception as e:
            messages.error(request, f'Error deleting employee: {str(e)}')

    return redirect('employee_list')


# method to add a new employee
def add_employee(request):
    # Fetch data for dropdowns
    departments = execute_query(
        "SELECT DepartmentID, CONCAT(DepartmentID, ': ', DepartmentName) AS DepartmentLabel FROM Department")
    job_titles = execute_query(
        "SELECT JobTitleID, CONCAT(JobTitleID, ': ', JobTitleName) AS JobTitleLabel FROM JobTitle")
    pay_grades = execute_query(
        "SELECT PayGradeID, CONCAT(PayGradeID, ': ', PayGradeName) AS PayGradeLabel FROM PayGrade")
    organizations = execute_query(
        "SELECT OrganizationID, CONCAT(OrganizationID, ': ', Name) AS OrganizationLabel FROM Organization")
    supervisors = execute_query("""SELECT NULL AS EmployeeID, 'None' AS EmployeeLabel
                                   UNION ALL
                                   SELECT EmployeeID, CONCAT(EmployeeID, ': ', EmployeeName) AS EmployeeLabel FROM Employee""")

    if request.method == 'POST':
        employee_name = request.POST.get('employee_name')
        date_of_birth = request.POST.get('dateofbirth')
        gender = request.POST.get('gender')
        marital_status = request.POST.get('Maritalstatus')
        address = request.POST.get('address')
        country = request.POST.get('country')
        organizationid = request.POST.get('Organizationid')
        department = request.POST.get('Departmentid')
        job_title = request.POST.get('Jobtitleid')
        paygrade = request.POST.get('Paygradeid')
        supervisor = request.POST.get('Supervisorid')
        number_of_leaves = request.POST.get('number_of_leaves')  # Default to 20 if not provided

        # Handle "None" supervisor
        if not supervisor:  # Convert empty string to None for SQL NULL
            supervisor = None

        if not number_of_leaves:
            number_of_leaves = 20

        out_param = OutParam()  # Ensure OutParam is properly defined elsewhere
        try:
            print("Going to call procedure")
            call_procedure('insert_employee',
                           [employee_name, date_of_birth, gender, marital_status, address, country,
                            organizationid, department, job_title, paygrade, supervisor, number_of_leaves, out_param])
            print("Called procedure")
            messages.success(request, 'Employee added successfully.')
        except Exception as e:
            print("Could not call procedure")
            messages.error(request, f"Error adding employee: {str(e)}")
        return redirect('employee_list')

    return render(request, 'add_employee.html', {
        'organizations': organizations,
        'departments': departments,
        'job_titles': job_titles,
        'pay_grades': pay_grades,
        'supervisors': supervisors,
    })


def job_title_list(request):
    # Query to fetch all job titles
    job_title_query = "SELECT * FROM JobTitle"
    job_titles = execute_query(job_title_query)

    context = {
        'job_titles': job_titles
    }
    return render(request, 'job_title_list.html', context)


def add_job_title(request):
    if request.method == 'POST':
        job_title_name = request.POST.get('job_title_name')
        try:
            call_procedure('insert_job_title', [job_title_name])
            messages.success(request, 'Job title added successfully.')
            return redirect('job_title_list')
        except Exception as e:
            messages.error(request, f'Error adding job title: {str(e)}')
    return render(request, 'add_job_title.html')


def edit_job_title(request, job_title_id):
    job_title = execute_query("SELECT * FROM JobTitle WHERE JobTitleID = %s", [job_title_id])[0]
    if request.method == 'POST':
        new_job_title_name = request.POST.get('job_title_name')
        try:
            call_procedure('update_job_title_name', [job_title_id, new_job_title_name])
            messages.success(request, 'Job title updated successfully.')
            return redirect('job_title_list')
        except Exception as e:
            messages.error(request, f'Error updating job title: {str(e)}')
    return render(request, 'edit_job_title.html', {'job_title': job_title})


def delete_job_title(request, job_title_id):
    if request.method == 'POST':
        try:
            call_procedure('delete_job_title', [job_title_id])
            messages.success(request, 'Job title deleted successfully.')
        except Exception as e:
            messages.error(request, f'Error deleting job title: {str(e)}')
    return redirect('job_title_list')


def organization_list(request):
    organization_query = "SELECT * FROM Organization"
    organizations = execute_query(organization_query)
    context = {
        'organizations': organizations
    }
    return render(request, 'organization_list.html', context)


def add_organization(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        address = request.POST.get('address')
        registration_number = request.POST.get('registration_number')
        try:
            call_procedure('insert_organization', [name, address, registration_number])
            messages.success(request, 'Organization added successfully.')
            return redirect('organization_list')
        except Exception as e:
            messages.error(request, f'Error adding organization: {str(e)}')
    return render(request, 'add_organization.html')


def edit_organization(request, organization_id):
    organization = execute_query("SELECT * FROM Organization WHERE OrganizationID = %s", [organization_id])[0]
    if request.method == 'POST':
        name = request.POST.get('name')
        address = request.POST.get('address')
        registration_number = request.POST.get('registration_number')
        try:
            call_procedure('update_organization', [organization_id, name, address, registration_number])
            messages.success(request, 'Organization updated successfully.')
            return redirect('organization_list')
        except Exception as e:
            messages.error(request, f'Error updating organization: {str(e)}')
    return render(request, 'edit_organization.html', {'organization': organization})


def delete_organization(request, organization_id):
    if request.method == 'POST':
        try:
            call_procedure('delete_organization', [organization_id])
            messages.success(request, 'Organization deleted successfully.')
        except Exception as e:
            messages.error(request, f'Error deleting organization: {str(e)}')
    return redirect('organization_list')


# ----------------------------Department--------------------------------------

# method to view department list
def department_list(request):
    # Query to fetch all departments
    department_query = "SELECT DepartmentID, DepartmentName FROM Department"
    departments = execute_query(department_query)

    context = {
        'departments': departments
    }
    return render(request, 'department_list.html', context)


# Method to create a new department
def add_department(request):
    if request.method == 'POST':
        department_name = request.POST.get('department_name')

        # Generate the next DepartmentID (example: max ID + 1)
        next_department_id = execute_query("SELECT IFNULL(MAX(DepartmentID), 0) + 1 AS NextID FROM Department")[0][
            'NextID']

        try:
            call_procedure('insert_department', [next_department_id, department_name])
            messages.success(request, 'Department added successfully.')
        except Exception as e:
            messages.error(request, f'Error adding department: {str(e)}')

    return redirect('department_list')


# method to update department
def edit_department(request, department_id):
    if request.method == 'POST':
        department_name = request.POST.get('department_name')
        try:
            # Call the procedure to update department name
            call_procedure('update_department_name', [department_id, department_name])
            messages.success(request, 'Department updated successfully.')
        except Exception as e:
            messages.error(request, f'Error updating department: {str(e)}')
        return redirect('department_list')  # Redirect to department list after editing

    return redirect('department_list')  # Default redirect


# method to delete department
def delete_department(request, department_id):
    if request.method == 'POST':
        try:
            call_procedure('delete_department', [department_id])
            messages.success(request, 'Department deleted successfully.')
        except Exception as e:
            messages.error(request, f'Error deleting department: {str(e)}')
    return redirect('department_list')


# -------------------------PayGrade-----------------------------------------

def paygrade_list(request):
    paygrade_query = "SELECT * FROM Paygrade"
    paygrades = execute_query(paygrade_query)
    context = {'paygrades': paygrades}  # Use a string key for the dictionary
    return render(request, 'paygrade_list.html', context)


def add_paygrade(request):
    if request.method == 'POST':
        paygrade_name = request.POST.get('paygrade_name')
        salary_amount = request.POST.get('salary_amount')
        try:

            call_procedure('insert_paygrade', [paygrade_name, salary_amount])
            messages.success(request, 'Paygrade added successfully.')
            return redirect('paygrade_list')

        except Exception as e:
            messages.error(request, f'Error adding paygrade: {str(e)}')
            return redirect('paygrade_list')

    return redirect('paygrade_list')


def edit_paygrade(request, paygrade_id):
    if request.method == 'POST':
        paygrade_name = request.POST.get('paygrade_name')
        salary_amount = request.POST.get('salary_amount')

        try:
            call_procedure('update_paygrade', [paygrade_id, paygrade_name, salary_amount])
            messages.success(request, 'Paygrade updated successfully.')
            return redirect('paygrade_list')

        except Exception as e:
            messages.error(request, f'Error updating paygrade: {str(e)}')
            return redirect('paygrade_list')

    redirect('paygrade_list')


def delete_paygrade(request, paygrade_id):
    if request.method == 'POST':
        try:
            # Call the delete stored procedure
            call_procedure('delete_paygrade', [paygrade_id])
            messages.success(request, 'PayGrade deleted successfully.')
        except Exception as e:
            messages.error(request, f'Error deleting PayGrade: {str(e)}')

    return redirect('paygrade_list')


def user_account_list(request):
    user_account_query = "SELECT * FROM UserAccount"
    user_accounts = execute_query(user_account_query)
    context = {'user_accounts': user_accounts}
    return render(request, 'user_account_list.html', context)


def add_user_account(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')
        employee_id = request.POST.get('employee_id')
        user_role = request.POST.get('user_role')

        # Hash the password before storing
        password_hash = make_password(password)

        try:
            call_procedure('CreateUserAccount',
                           [username, email, password_hash, employee_id, user_role])
            messages.success(request, 'User account added successfully.')
        except Exception as e:
            messages.error(request, f'Error adding user account: {str(e)}')

        return redirect('user_account_list')

    return render(request, 'add_user_account.html')


def edit_user_account(request, user_account_id):
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password = request.POST.get('password')
        employee_id = request.POST.get('employee_id')
        user_role = request.POST.get('user_role')

        # Only update password if a new one is provided
        if password:
            password_hash = make_password(password)
        else:
            # Fetch current password hash
            current_user = \
            execute_query("SELECT PasswordHash FROM UserAccount WHERE UserAccountID = %s",
                          [user_account_id])[0]
            password_hash = current_user['PasswordHash']

        try:
            call_procedure('UpdateUserAccount',
                           [user_account_id, username, email, password_hash, employee_id,
                            user_role])
            messages.success(request, 'User account updated successfully.')
        except Exception as e:
            messages.error(request, f'Error updating user account: {str(e)}')

        return redirect('user_account_list')

    user_account = \
    execute_query("SELECT * FROM UserAccount WHERE UserAccountID = %s", [user_account_id])[0]
    return render(request, 'edit_user_account.html', {'user_account': user_account})


def delete_user_account(request, user_account_id):
    if request.method == 'POST':
        try:
            call_procedure('delete_UserAccount', [user_account_id])
            messages.success(request, 'User account deleted successfully.')
        except Exception as e:
            messages.error(request, f'Error deleting user account: {str(e)}')

    return redirect('user_account_list')



def logout_view(request):
    logout(request)
    messages.success(request, "You have been successfully logged out.")
    return redirect('staffsync-login')
