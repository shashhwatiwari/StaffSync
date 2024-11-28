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


# def call_procedure(procedure_name, params=None):
#     with connection.cursor() as cursor:
#         if params:
#             cursor.callproc(procedure_name, params)
#         else:
#             cursor.callproc(procedure_name)
#
#         if cursor.description:
#             columns = [col[0] for col in cursor.description]
#             return [dict(zip(columns, row)) for row in cursor.fetchall()]
#         return cursor.rowcount
#

def call_procedure(procedure_name, params=None):
    with connection.cursor() as cursor:
        if params:
            out_params = [p for p in params if isinstance(p, OutParam)]
            in_params = [p for p in params if not isinstance(p, OutParam)]
            cursor.callproc(procedure_name, in_params + [p.value for p in out_params])

            # Fetch any result sets
            results = list(cursor.fetchall())

            # Get OUT parameter values
            if out_params:
                cursor.execute('SELECT ' + ','.join(['@_' + procedure_name + '_' + str(i) for i in
                                                     range(len(in_params), len(params))]))
                out_values = cursor.fetchone()
                for i, out_param in enumerate(out_params):
                    out_param.value = out_values[i]
        else:
            cursor.callproc(procedure_name)
            results = list(cursor.fetchall())

        if cursor.description:
            columns = [col[0] for col in cursor.description]
            return [dict(zip(columns, row)) for row in results]
        return cursor.rowcount


# For procedures that have an out parameter, for example the add_dependent procedure returning the new Dependent ID
class OutParam:
    def __init__(self):
        self.value = None