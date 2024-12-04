# StaffSync - CS5200 Project

An employee management system that involves CRUD operations on different tables. The database 
contains 10 tables and procedures/triggers relevant for those tables. The application is made as a 
web-app where a user can login. Post logging in the user is taken to their concerned dashboard that
has the intuitive buttons enabling them to carry out operations that they are allowed to do.

## Prerequisites

Before running this project, ensure you have the following installed:

Python 3.8 or higher
<br>Django 4.x
MySQL Server
<br>pymysql for Python-MySQL communication
<br>Other dependencies listed in the requirements.txt file. 


## Setup Instructions

1. Technology Download Links _(requirement file also contains command to install Django)_<br>
Python: https://www.python.org/downloads/ <br>
MySQL Server: https://dev.mysql.com/downloads/ <br>
Django: https://www.djangoproject.com/


2. Clone or Extract Project Files: Extract the project files into a directory on your computer.<br><br>

3. Creating a virtual environment _(optional)_ : <br>
`python3 -m venv venv source venv/bin/activate`

     For Windows : <br>
    `venv\Scripts\activate`


4. Install the dependencies
   <br>
   i) Through the requirements.txt file as follows : <br>
    `pip install -r requirements.txt`
    <br> 

    ii) Or individually as follows : <br>
    `pip install django pymysql django-environ`
<br>


5. If not already created, import the provided SQL dump file to set up `StaffSync` database being used in this project: <br>
  `mysql -u <username> -p < StaffSyncDump.sql`

    Replace "username" with your MySQL username. 


6. Set up the environment variables :

    i. Please refer to the .env.example file for database configuration settings. 
    Create a .env file in the staffsyncDjango directory, then copy the content from .env.example 
    into it. Update the DB_USER and DB_PASSWORD fields with your respective username and password

    ii. Alternatively :
    Create a new ".env" file in the staffsyncDjango directory and replace the 'DB_USER' and 
    'DB_PASSWORD' section with your respective user and password in the provided  <br>


       DATABASE_NAME= StaffSync
       DATABASE_USER= "your_database_user"
       DATABASE_PASSWORD= "your_database_password"
       DATABASE_HOST=localhost
       DATABASE_PORT=3306

    
7. Run migrations: <br>
 `python manage.py makemigrations` <br>
 `python manage.py migrate`




## Instruction on how to run the application


Start the development server: <br>

1. Ensure that MySQL is running and that you have access to the `StaffSync` database. <br>


2. Once you are through with importing the database through the database dump provided, follow the given steps to run the application.<br>


3. Open Terminal, and navigate to the directory - `staffsyncDjango`. Now, run the local host server using the following command : <br>
`python manage.py runserver`

    The server should now be running and you would get the following result on terminal: <br>
    Starting development server at http://127.0.0.1:8000/

Simply go to the browser and copy the presented link in your terminal and the webapp should be functional.
<br>
You should be presented with the following login page.


 











  

