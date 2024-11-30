from django.shortcuts import render, redirect
from .db_utils import execute_query, call_procedure, OutParam
from django.contrib import messages

from .models import Employee


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


#Method to update a dependent
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



#Method to delete a dependent
def delete_dependent(request, dependent_id):
    if request.method == 'POST':
        try:
            call_procedure('delete_dependent', [dependent_id])
            #messages.success(request, 'Dependent deleted successfully.')
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


#Method to add an employees emergency contact
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


#Method to update an emergency contact
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


#Method to delete emergency contact for an employee
def delete_emergency_contact(request, contact_id):
    if request.method == 'POST':
        try:
            call_procedure('delete_emergency_contact', [contact_id])
        except Exception as e:
            messages.error(request, f'Error deleting emergency contact: {str(e)}')

    return redirect('employee-emergencycontact')


# -------------------------------------------------------------------------------------------------------------------------------------------------

#Method to log a leave

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



#Method to view leaves logged by an employee.
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
            #messages.success(request, 'Employee updated successfully.')
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

def delete_employee(request, employee_id):
    if request.method == 'POST':
        try:
            # Delete the employee using Django ORM, which will trigger the before_employee_delete trigger
            call_procedure('delete_employee',[employee_id])  # The trigger will automatically be called here

            # Optionally, you can add a success message
            messages.success(request, 'Employee deleted successfully.')
        except Employee.DoesNotExist:
            messages.error(request, 'Employee not found.')
        except Exception as e:
            messages.error(request, f'Error deleting employee: {str(e)}')

    return redirect('modify-employee')

