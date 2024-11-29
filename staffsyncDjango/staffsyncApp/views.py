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
    employee_data = call_procedure('GetEmployeeDetails', [user_id]) # procedure call to SQL database

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
            messages.success(request, 'Dependent updated successfully.')
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
