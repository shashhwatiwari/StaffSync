from django.shortcuts import render, redirect
from .db_utils import execute_query, call_procedure


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




# Method to view employee dependents
def view_dependents(request):
    if 'user_id' not in request.session:
        return redirect('login')

    user_id = request.session['user_id']
    dependents = call_procedure('get_employee_dependents', [user_id])
    return render(request, 'view_dependents.html', {'dependents': dependents})



# Method to view employee emergency contacts
def view_emergency_contacts(request):
    if 'user_id' not in request.session:
        return redirect('login')

    user_id = request.session['user_id']
    contacts = call_procedure('get_employee_emergency_contacts', [user_id])
    return render(request, 'view_emergency_contacts.html', {'contacts': contacts})
