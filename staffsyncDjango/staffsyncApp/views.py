from django.contrib.auth import authenticate, login
from django.shortcuts import render, redirect
from django.contrib import messages
from .models import Employee, Useraccount  # Assuming you have a 'Useraccount' model

def login_view(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)

            # Check if the user is an HR by checking the jobtitle
            try:
                # Get the corresponding Useraccount instance using 'username'
                useraccount = Useraccount.objects.get(username=username)  # Query using 'username'
                employee = Employee.objects.get(useraccount=useraccount)

                if employee.departmentid == 'Human Resources':
                    return redirect('staffsync-hr', userid=user.id)
                else:
                    messages.error(request, 'You do not have the required role to access this page.')
                    return redirect('login')  # Or redirect to another page (e.g., home page)
            except Useraccount.DoesNotExist:
                messages.error(request, 'No user account found for this user.')
                return redirect('login')  # Handle case where Useraccount does not exist
            except Employee.DoesNotExist:
                messages.error(request, 'No employee data found for this user.')
                return redirect('login')  # Handle case where Employee does not exist
        else:
            messages.error(request, 'Username or password is incorrect')

    return render(request, 'login.html')


def hr_view(request, userid):
    # Check if the user is logged in and has the 'HR' jobtitle
    try:
        useraccount = Useraccount.objects.get(username=request.user.username)  # Get Useraccount using 'username'
        employee = Employee.objects.get(useraccount=useraccount)

        if employee.departmentid != 'Human Resources':
            messages.error(request, 'You do not have permission to view this page.')
            return redirect('login')  # Or redirect to another page (e.g., home page)
    except Useraccount.DoesNotExist:
        messages.error(request, 'No user account found for this user.')
        return redirect('login')
    except Employee.DoesNotExist:
        messages.error(request, 'No employee data found for this user.')
        return redirect('login')

    return render(request, 'hr_view.html', {'userid': userid})
