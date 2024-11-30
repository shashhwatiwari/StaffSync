from django.shortcuts import render, redirect
from .db_utils import execute_query, call_procedure, OutParam
from django.contrib import messages


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
            request.session['user_id'] = user['EmployeeID']
            request.session['user_role'] = user['User_Role']
            print(f"User role: {user['User_Role']}")  # Debug print

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

    # Fetch specific employee data
    query = """
    SELECT EmployeeID, EmployeeName, DateOfBirth, DepartmentID, JobTitleID, PayGradeID, SupervisorID
    FROM Employee
    """
    employees = execute_query(query)
    return render(request, 'hr-home.html', {'employees': employees})


# Method for Regular Employees
def employee_home(request):
    if 'user_id' not in request.session:
        return redirect('login')

    user_id = request.session['user_id']

    # Fetch employee's own data
    employee_data = call_procedure('GetEmployeeDetails', [user_id])  # procedure call to SQL database

    return render(request, 'employee-home.html',
                  {'employee': employee_data[0] if employee_data else None})


# -------------------------------------------------------------------------------------------------------------------------------------------------
# CRUD Methods for Employee Dependents

# Method to view employee dependents
def view_dependents(request):
    if 'user_id' not in request.session:
        return redirect('login')

    user_id = request.session['user_id']
    dependents = call_procedure('get_employee_dependents', [user_id])
    print("Dependents:", dependents)
    return render(request, 'view_dependents.html', {'dependents': dependents})


# Method to add new dependents
def add_dependent(request):
    if request.method == 'POST':
        employee_id = request.session.get('user_id')
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
            print(f"Debug: New dependent ID: {out_param.value}")
            # messages.success(request, f'Dependent added successfully. ID: {out_param.value}')
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
            messages.success(request, 'Dependent updated successfully.')
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

    user_id = request.session['user_id']
    contacts = call_procedure('get_employee_emergency_contacts', [user_id])
    return render(request, 'view_emergency_contacts.html', {'contacts': contacts})


# method to view the audit logs:
def admin_home(request):
    if 'user_id' not in request.session:
        return redirect('login')
    query = "SELECT * FROM AuditLog ORDER BY Timestamp DESC"  # You can add filtering or sorting as needed
    auditlogs = execute_query(query)  # Assuming `execute_query` returns a list of rows

    return render(request, 'admin-home.html', {'auditlogs': auditlogs})


def modify_employee(request):
    # Query to fetch employee data
    query = "SELECT EmployeeID, EmployeeName, DepartmentID, JobTitleID FROM Employee"
    employees = execute_query(query)  # Assuming `execute_query` returns a list of dictionaries with employee data

    # Render the employee list template and pass the employee data
    return render(request, 'employee_list.html', {'employees': employees})

def edit_employee(request, employee_id):
    # Fetch the employee data based on the provided employee_id
    query = """
    SELECT EmployeeID, EmployeeName, DateOfBirth, Gender, Address, MaritalStatus, OrganizationID, DepartmentID, JobTitleID, PayGradeID, SupervisorID
    FROM Employee
    WHERE EmployeeID = %s
    """
    employee_data = execute_query(query, [employee_id])

    if not employee_data:
        return redirect('modify-employee')

    employee = employee_data[0]

    # Ensure DateOfBirth is in the correct format (YYYY-MM-DD)
    if employee.get('DateOfBirth'):
        employee['DateOfBirth'] = employee['DateOfBirth'].strftime('%Y-%m-%d')

    if request.method == 'POST':
        # If the form is submitted, update the employee data
        new_employee_name = request.POST.get('employee_name')
        new_date_of_birth = request.POST.get('dateofbirth')
        new_gender = request.POST.get('gender')
        new_address = request.POST.get('address')
        new_marital_status = request.POST.get('Maritalstatus')
        new_organization_id = request.POST.get('Organizationid')
        new_department_id = request.POST.get('Departmentid')
        new_job_title_id = request.POST.get('Jobtitleid')
        new_paygrade_id = request.POST.get('Paygradeid')
        new_supervisor_id = request.POST.get('Supervisorid')

        # If SupervisorID is empty, set it to None (NULL in the database)
        if new_supervisor_id == '':
            new_supervisor_id = None

        # Ensure DateOfBirth is in the correct format (YYYY-MM-DD)
        if new_date_of_birth:
            new_date_of_birth = new_date_of_birth  # If any transformation is needed, you can add it here

        update_query = """
        UPDATE Employee
        SET EmployeeName = %s, DateOfBirth = %s, Gender = %s, Address = %s, MaritalStatus = %s,
            OrganizationID = %s, DepartmentID = %s, JobTitleID = %s, PayGradeID = %s, SupervisorID = %s
        WHERE EmployeeID = %s
        """

        execute_query(update_query, [
            new_employee_name, new_date_of_birth, new_gender, new_address, new_marital_status,
            new_organization_id, new_department_id, new_job_title_id, new_paygrade_id, new_supervisor_id, employee_id
        ])

        # Redirect back to the employee list page after updating
        return redirect('modify-employee')

    return render(request, 'edit_employee.html', {'employee': employee})

# def delete_employee(request, employee_id):
#     if request.method == 'POST':
#         try:
#             call_procedure('delete_dependent', [employee_id])
#             # messages.success(request, 'Dependent deleted successfully.')
#         except Exception as e:
#             messages.error(request, f'Error deleting employee: {str(e)}')
#     return redirect('modify-employee')
