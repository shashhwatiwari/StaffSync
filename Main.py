import pymysql
from pymysql import OperationalError


def connect_to_database():
    """
    Attempts to connect to the MySQL database.

    Raises: error if the user provides invalid credentials or if the program fails to establish a
    connection.
    """
    while True:
        print("default: (localhost)")
        user = input("Enter your MySQL username: ")
        password = input("Enter your MySQL password: ")

        try:
            connection = pymysql.connect(
                host='localhost',
                user=user,
                password=password,
                database="StaffSync",
                cursorclass=pymysql.cursors.DictCursor
            )
            print(f"Successfully connected to the database 'StaffSync' as '{user}'!\n")
            return connection
        except OperationalError as e:
            if "Access denied" in str(e):
                print("Invalid username or password. Please try again.\n") #throws error for incorrect password or username.
            else:
                print(f"Error connecting to MySQL: {e}\nPlease retry\n") #throws error when unable to establish connection.



if __name__ == '__main__':
    connection = connect_to_database()
