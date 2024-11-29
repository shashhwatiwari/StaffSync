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
            else:
                print("Redirecting to employee home")  # Debug print
                return redirect('employee-home')
        else:
            print("Authentication failed")  # Debug print
            # Pass error message to the template
            return render(request, 'login.html', {'error': 'Invalid username or password.'})

    # Render the login page without error for GET requests
    return render(request, 'login.html')



#Method for HR page
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



#Method to view the audit logs:
def admin_home(request):
    if 'user_id' not in request.session:
        return redirect('login')
    query = "SELECT * FROM AuditLog ORDER BY Timestamp DESC"  # You can add filtering or sorting as needed
    auditlogs = execute_query(query)  # Assuming `execute_query` returns a list of rows

    return render(request, 'admin-home.html', {'auditlogs': auditlogs})




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
            #messages.success(request, f'Dependent added successfully. ID: {out_param.value}')
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
            #messages.success(request, 'Dependent updated successfully.')
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

    user_id = request.session['user_id']
    contacts = call_procedure('get_employee_emergency_contacts', [user_id])
    return render(request, 'view_emergency_contacts.html', {'contacts': contacts})


#Method to add an employees emergency contact
def add_emergency_contact(request):
    if request.method == 'POST':
        employee_id = request.session.get('user_id')
        contact_name = request.POST.get('contact_name')
        phone_number = request.POST.get('phone_number')
        address = request.POST.get('address')

        out_param = OutParam()
        try:
            call_procedure('insert_emergency_contact',
                           [employee_id, contact_name, phone_number, address, out_param])
            #messages.success(request, 'Emergency contact added successfully.')
        except Exception as e:
            messages.error(request, f'Error adding emergency contact: {str(e)}')
        # this line
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
            #messages.success(request, 'Emergency contact updated successfully.')
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
            #messages.success(request, 'Emergency contact deleted successfully.')
        except Exception as e:
            messages.error(request, f'Error deleting emergency contact: {str(e)}')

    return redirect('employee-emergencycontact')


# -------------------------------------------------------------------------------------------------------------------------------------------------

