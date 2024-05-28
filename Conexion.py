import psycopg2
from datetime import datetime

class Conexion:
    def __init__(self):
        try:
            self.conectado = psycopg2.connect(
                host='localhost',
                database='ClasesDefinitiva',
                user='gaspar',
                password='armando1gaspar'
            )
            self.PID = self.getPID()

        except psycopg2.Error as e:
            print("Error al conectar a la base de datos:", e)

    def getPID(self):
        cursor = self.conectado.cursor()
        try:
            cursor.execute('select pg_backend_pid()')
            return cursor.fetchone()[0]
        except psycopg2.Error as e:
            print("Error al obtener PID:", e)
            return None

    def verificar_user(self, nombre, password):
        cursor = self.conectado.cursor()
        try:
            cursor.execute('SELECT * FROM public.verify_user(%s, %s)', (nombre, password))
            return cursor.fetchone()[0]
        except psycopg2.Error as e:
            print("Error al verificar usuario:", e)
            return None

    def recuperarCredenciales(self, id_user):
        cursor = self.conectado.cursor()
        try:                                    
            cursor.execute("SELECT recuperar_credenciales(%s)", (id_user,))
            return cursor.fetchall()
        except psycopg2.Error as e:
            print("Error al recuperar credenciales:", e)
            return None

    def obtenerRol(self, id_rol):
        cursor = self.conectado.cursor()
        try:
            cursor.execute("select obtener_rol(%s)", (id_rol,))
            return cursor.fetchone()[0]
        except psycopg2.Error as e:
            print("Error al obtener rol:", e)
            return None

    def insertInSesion(self, id_user):
        cursor = self.conectado.cursor()
        current_date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        try:
            cursor.execute('INSERT INTO public.sesion (ci, PID, activos, fecha_sesion) VALUES (%s, %s, TRUE, %s)',
                           (id_user, self.PID, current_date))
            self.conectado.commit()
        except psycopg2.Error as e:
            print("Error al insertar en sesión:", e)

    def obtenerCursos(self, id_user):
        cursor = self.conectado.cursor()
        try:
            cursor.execute("SELECT * FROM obtener_cursos(%s)", (id_user,))
            return cursor.fetchall()
        except psycopg2.Error as e:
            print("Error al obtener cursos:", e)
            return None

    def crearTarea(self, id_clase, fecha_limite, titulo, descripcion):
        cursor = self.conectado.cursor()
        try:
            cursor.execute('SELECT crear_tarea(%s,%s,%s, %s)', (id_clase, fecha_limite, titulo, descripcion))
            self.conectado.commit()
        except psycopg2.Error as e:
            print("Error al crear tarea:", e)

    def obtenerTareasAsignadas(self, id_user):
        cursor = self.conectado.cursor()
        try:
            cursor.execute('select * from obtener_tareas_asignadas(%s)', (id_user,))
            return cursor.fetchall()
        except psycopg2.Error as e:
            print("Error al obtener tareas asignadas:", e)
            return None

    def entregarTarea(self, id_tarea, id_curso, id_user, archivo, comentario, idTipoArchivo):
        cursor = self.conectado.cursor()
        try:
            cursor.execute('SELECT entregar_tarea(%s,%s,%s, %s, %s, %s)', (id_tarea, id_curso, id_user, archivo, comentario, idTipoArchivo))
            self.conectado.commit()
        except psycopg2.Error as e:
            print("Error al entregar tarea:", e)

    def obtenerTareasEntregadas(self, id_user):
        cursor = self.conectado.cursor()
        try:
            cursor.execute('select * from obtener_tareas_entregadas(%s)', (id_user,))
            return cursor.fetchall()
        except psycopg2.Error as e:
            print("Error al obtener tareas entregadas:", e)
            return None

    def obteneridTipoArchivo(self, rutaArchivo):
        cursor = self.conectado.cursor()
        try:
            cursor.execute('select * from tipo_archivo')
            tipos = cursor.fetchall()
            extension = rutaArchivo.split('.')[-1].lower()
            for tipo in tipos:
                if(tipo[1] == extension):
                    return tipo[0]
            return "Extension no valida"
        except psycopg2.Error as e:
            print("Error al obtener tipo de archivo:", e)
            return None

    def cerrarSesion(self):
        cursor = self.conectado.cursor()
        try:
            cursor.execute('SELECT cerrar_sesion(%s)', (self.PID,))
            self.conectado.commit()
        except psycopg2.Error as e:
            print("Error al cerrar sesión:", e) 

    def obtenerDatosPersonales(self, id_user):
        cursor = self.conectado.cursor()
        try:
            cursor.execute('select * from obtener_datos_personal(%s)', (id_user,))
            return cursor.fetchone()
           
        except psycopg2.Error as e:
            print("Error al obtener datos personales:", e)
            return None

    def calificarEntrega(self, id_tarea, id_curso, id_user, fecha, calificacion):
        cursor = self.conectado.cursor()
        try:
            cursor.execute('SELECT calificar_entrega(%s, %s, %s, %s, %s)', (id_tarea, id_curso, id_user, fecha, calificacion))
            self.conectado.commit()
        except psycopg2.Error as e:
            print("Error al calificar entrega:", e)
