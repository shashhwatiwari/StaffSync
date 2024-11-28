from django.db import connection

def execute_query(query, params=None):
    with connection.cursor() as cursor:
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
        if query.strip().upper().startswith('SELECT'):
            columns = [col[0] for col in cursor.description]
            return [dict(zip(columns, row)) for row in cursor.fetchall()]
        else:
            return cursor.rowcount



def call_procedure(procedure_name, params=None):
    with connection.cursor() as cursor:
        if params:
            cursor.callproc(procedure_name, params)
        else:
            cursor.callproc(procedure_name)

        if cursor.description:
            columns = [col[0] for col in cursor.description]
            return [dict(zip(columns, row)) for row in cursor.fetchall()]
        return cursor.rowcount