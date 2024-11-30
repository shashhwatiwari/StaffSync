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






# -------------------------------------------------------------------------------------------------------------------------------------------------
# Methods for CRUD Functionality for the Admin view.




#Method to show the list of employees in the database currently when we click the modify employee button.
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


#Method to edit the employee details.
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
    departments = execute_query("SELECT DepartmentID, CONCAT(DepartmentID, ': ', DepartmentName) AS DepartmentLabel FROM Department")
    job_titles = execute_query("SELECT JobTitleID, CONCAT(JobTitleID, ': ', JobTitleName) AS JobTitleLabel FROM JobTitle")
    pay_grades = execute_query("SELECT PayGradeID, CONCAT(PayGradeID, ': ', PayGradeName) AS PayGradeLabel FROM PayGrade")
    organizations = execute_query("SELECT OrganizationID, CONCAT(OrganizationID, ': ', Name) AS OrganizationLabel FROM Organization")
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



#Method to delete an employee record from the databae altogether.
# def delete_employee(request, employee_id):
#     if request.method == 'POST':
#         try:
#             call_procedure('delete_dependent', [employee_id])
#             # messages.success(request, 'Dependent deleted successfully.')
#         except Exception as e:
#             messages.error(request, f'Error deleting employee: {str(e)}')
#     return redirect('modify-employee')
