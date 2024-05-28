import tkinter as tk
from tkinter import BOTH, LEFT, RIGHT, VERTICAL, Y, Canvas, Frame, Label, OptionMenu, StringVar, messagebox
from tkinter import filedialog
from tkinter import ttk

import psycopg2
from Conexion import Conexion
from PIL import Image, ImageTk
from io import BytesIO

class Login:
    def __init__(self):
        
        self.init_ventana()
        self.definirFormulario()
        
        """ self.imagenFondo = Image.open("fondol.png")
        self.imagenFondo = self.imagenFondo.resize((980, 620)) 
        self.imagenFondo_tk = ImageTk.PhotoImage(self.imagenFondo) """
        
        self.root.mainloop()
    
    
    def center_window(self, window, width, height):
        screen_width = window.winfo_screenwidth()
        screen_height = window.winfo_screenheight()

        x_coordinate = (screen_width - width) // 2
        y_coordinate = (screen_height - height) // 2

        window.geometry(f"{width}x{height}+{x_coordinate}+{y_coordinate}")
    
    def init_ventana(self):
        self.root = tk.Tk()
        self.root.title("Login")
        self.root.geometry("980x600")
        imagen = Image.open("fondo2.png")
        imagen = imagen.resize((780, 420)) 
        imagen_tk = ImageTk.PhotoImage(imagen)
        self.center_window(self.root, 780, 400)

        label_imagen = tk.Label(self.root, image=imagen_tk)
        label_imagen.image = imagen_tk
        label_imagen.pack()
        
    def definirFormulario(self):
        # Etiqueta y campo de entrada para Usuario
        self.label_username = tk.Label(self.root, text="Usuario:", width=10, fg="blue")
        self.label_username.place(x=220, y=100)
        self.entry_username = tk.Entry(self.root, width=30)
        self.entry_username.place(x=220, y=150)

        # Etiqueta y campo de entrada para Contraseña
        self.label_password = tk.Label(self.root, text="Contraseña:", width=10, fg="blue")
        self.label_password.place(x=220, y=200)
        self.entry_password = tk.Entry(self.root, show="*", width=30)
        self.entry_password.place(x=220, y=250)

        # Botón de Iniciar Sesión
        self.btn_login = tk.Button(self.root, text="Iniciar sesión", command=self.login, width=35, bg="green", fg="white")
        self.btn_login.place(x=300, y=350)

        # Título del formulario
        self.label_title = tk.Label(self.root, text="Login", width=10, font=("Arial", 20, "bold"), fg="red")
        self.label_title.place(x=300, y=50)

    def login(self):
        username = self.entry_username.get()
        password = self.entry_password.get()
            
        conexion = Conexion()
        
        id_user = conexion.verificar_user(username, password)

        if id_user:
            messagebox.showinfo("Login", "Inicio de sesión exitoso")
            conexion.insertInSesion(id_user)
            self.mostrarInterfaces(id_user, conexion)
        else:
            messagebox.showerror("Login", "Inicio de sesion fallido")
                
     
    def cerrarSesion(self, id_user):
        print(f"se cerro la sesion de {id_user}")
        self.root_home.destroy()
     
    def mostrarInterfaces(self,id_user, conexion):
        # self.init_ventana_home()
        interfaces = conexion.recuperarCredenciales(id_user)
        datosPersonales = conexion.obtenerDatosPersonales(id_user)
        root_home = tk.Tk()
        root_home.title("Login")
        root_home.geometry("700x800")
        root_home.configure(bg='#000') 
        
        panel = tk.Frame(root_home, width=500, height=320, bg='#333')  # Panel con fondo oscuro
        panel.pack(pady=100)
        
        
        root_home.protocol("WM_DELETE_WINDOW",lambda: (   
                   conexion.cerrarSesion(),
                   root_home.destroy()
                   )) 
        
        self.label_datos = tk.Label(panel, text=f"{datosPersonales[1]}: {datosPersonales[0]} :  {datosPersonales[2]}", bg='#333', fg='white') 
        self.label_datos.pack()
       
        
        for interfaz in interfaces:
            if interfaz[0] == 'Dar tarea':
                self.btn_login = tk.Button(panel, text=interfaz[0], command=lambda:self.interfaz_darTarea(id_user, conexion),
                               bg='#007BFF', fg='white',  # colores de fondo y texto
                               font=('Arial', 12),  # fuente y tamaño de texto
                               bd=2, relief=tk.RAISED,  # bordes y relieve
                               padx=20, pady=15)
                self.btn_login.pack(pady=15, padx=20)
                continue 
               
            if interfaz[0] == 'ver entregas':
               self.btn_login = tk.Button(panel, text=interfaz[0], command=lambda:self.interfaz_verEntregas(id_user, conexion),
                               bg='#007BFF', fg='white',  # colores de fondo y texto
                               font=('Arial', 12),  # fuente y tamaño de texto
                               bd=2, relief=tk.RAISED,  # bordes y relieve
                               padx=20, pady=15)  # padding interno
               self.btn_login.pack(pady=15, padx=20)
               continue
               
            if interfaz[0] == 'ver planilla':
                self.btn_login = tk.Button(panel, text=interfaz[0], command=self.verPlanilla, state=tk.DISABLED,
                               bg='#f0f0f0', fg='#808080',  
                               font=('Arial', 12), 
                               bd=2, relief=tk.GROOVE,  
                               padx=20, pady=15)  
                self.btn_login.pack(pady=15, padx=20)
                continue
               
            if interfaz[0] == 'subir tarea':
                self.btn_login = tk.Button(panel, text=interfaz[0], command=lambda:self.interfaz_subirTarea(id_user, conexion),
                               bg='#007BFF', fg='white',  # colores de fondo y texto
                               font=('Arial', 12),  # fuente y tamaño de texto
                               bd=2, relief=tk.RAISED,  # bordes y relieve
                               padx=20, pady=15)
                self.btn_login.pack(pady=15, padx=20)
                continue
            
            if interfaz[0] == 'ver notas':
                self.btn_login = tk.Button(panel, text=interfaz[0], command=self.verPlanilla, state=tk.DISABLED,
                               bg='#f0f0f0', fg='#808080',  
                               font=('Arial', 12), 
                               bd=2, relief=tk.GROOVE,  
                               padx=20, pady=15)  
                self.btn_login.pack(pady=15, padx=20)
                continue
            
            if interfaz[0] == 'ver materias inscritas':
                self.btn_login = tk.Button(panel, text=interfaz[0], command=self.verPlanilla, state=tk.DISABLED,
                               bg='#f0f0f0', fg='#808080',  
                               font=('Arial', 12), 
                               bd=2, relief=tk.GROOVE,  
                               padx=20, pady=15)  
                self.btn_login.pack(pady=15, padx=20)
                continue
            
            
    def interfaz_darTarea(self, id_user, conexion):
        cursos = conexion.obtenerCursos(id_user)
        
        # Crear la ventana para el formulario
        panel = tk.Tk()
        panel.title("Publicar tarea")
        panel.geometry("980x600")
        panel.configure(bg='black')  # Establecer fondo negro para la ventana

        # Etiqueta principal
        self.label_darTareaEst = tk.Label(panel, text="Publicar tarea", bg='black', fg='white', font=('Arial', 18, 'bold'))
        self.label_darTareaEst.pack(pady=20)

        # Formulario para el título
        self.label_titulo = tk.Label(panel, text="Título:", bg='black', fg='white', font=('Arial', 12))
        self.label_titulo.pack()
        self.entry_titulo = tk.Entry(panel, width=50)
        self.entry_titulo.pack()

        # Formulario para la descripción
        self.label_descripcion = tk.Label(panel, text="Descripción:", bg='black', fg='white', font=('Arial', 12))
        self.label_descripcion.pack()
        self.entry_descripcion = tk.Text(panel, width=50, height=8)
        self.entry_descripcion.pack()

        # Fecha límite
        self.label_fecha = tk.Label(panel, text="Fecha límite", bg='black', fg='white', font=('Arial', 20))
        self.label_fecha.pack()
        self.entry_fecha = tk.Entry(panel, width=60)
        self.entry_fecha.pack()

        # Selección de cursos
        self.valor = StringVar(panel)
        self.valor.set(cursos[0])

        self.label_cursos = Label(panel, text="Curso:", bg='black', fg='white', font=('Arial', 12))
        self.label_cursos.pack()

        self.options_cursos = OptionMenu(panel, self.valor, *cursos)
        self.options_cursos.pack()

        # Botón para enviar la tarea
        self.btn_mandar_tarea = tk.Button(panel, text="Mandar tarea", bg='#007BFF', fg='white', font=('Arial', 14, 'bold'),
                                           command=lambda: self.registrarTarea(conexion))
        self.btn_mandar_tarea.pack(pady=30)

        # Posicionamiento de los formularios
        x_offset = 260
        y_positions = [50, 150, 300, 400]
        widgets = [
            (self.label_titulo, self.entry_titulo),
            (self.label_descripcion, self.entry_descripcion),
            (self.label_fecha, self.entry_fecha),
            (self.label_cursos, self.options_cursos)
        ]

        for i, (label, widget) in enumerate(widgets):
            label.place(x=x_offset, y=y_positions[i])
            widget.place(x=x_offset, y=y_positions[i] + 50)

        self.btn_mandar_tarea.place(x=350, y=500)

        
        
    def registrarTarea(self, conexion):
       titulo = self.entry_titulo.get()
       descripcion = self.entry_descripcion.get("1.0", "end-1c")
       fecha_limite = self.entry_fecha.get()
       id_curso = int(self.valor.get()[1])
       conexion.crearTarea(id_curso, fecha_limite, titulo, descripcion)
       messagebox.showinfo("Login", "Registro exitoso")
        
    
    def interfaz_subirTarea(self, id_user, conexion):
        tareas = conexion.obtenerTareasAsignadas(id_user)
        
        # Crear la ventana para mostrar las tareas asignadas
        ventanita = tk.Tk()
        ventanita.title("Tablón de Tareas")
        ventanita.geometry("980x600")
        ventanita.configure(bg='black')  # Establecer fondo negro para la ventana
        
        # Frame principal y canvas con scrollbar
        main_frame = Frame(ventanita, bg='black')
        main_frame.pack(fill=BOTH, expand=1)
        
        my_canvas = Canvas(main_frame, bg='black')
        my_canvas.pack(side=tk.LEFT, fill=BOTH, expand=1)
        
        my_scrollbar = ttk.Scrollbar(main_frame, orient=VERTICAL, command=my_canvas.yview)
        my_scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        
        my_canvas.configure(yscrollcommand=my_scrollbar.set)
        my_canvas.bind('<Configure>', lambda e: my_canvas.configure(scrollregion=my_canvas.bbox("all")))
        
        second_frame = Frame(my_canvas, bg='black')
        my_canvas.create_window((0, 0), window=second_frame, anchor=tk.NW)
        
        # Título de la sección
        label_titulo = tk.Label(second_frame, text="TABLÓN DE TAREAS", bg='black', fg='white', font=('Arial', 16, 'bold'))
        label_titulo.pack(pady=20)
        
        # Mostrar cada tarea en la interfaz
        for tarea in tareas:
            # Fecha de publicación
            tk.Label(second_frame, text=f"FECHA PUBLICADO: {tarea[2]}", bg='black', fg='white', font=('Arial', 10)).pack(anchor=tk.W)
            
            # Fecha límite
            tk.Label(second_frame, text=f"FECHA LÍMITE: {tarea[3]}", bg='black', fg='white', font=('Arial', 10)).pack(anchor=tk.W)
            
            # Curso al que pertenece la tarea
            tk.Label(second_frame, text=f"CURSO: {tarea[6]}", bg='black', fg='white', font=('Arial', 10)).pack(anchor=tk.W)
            
            # Título de la tarea
            tk.Label(second_frame, text=f"TÍTULO: {tarea[4]}", bg='black', fg='white', font=('Arial', 10, 'bold')).pack(anchor=tk.W)
            
            # Descripción de la tarea
            tk.Label(second_frame, text=f"DESCRIPCIÓN: {tarea[5]}", bg='black', fg='white', font=('Arial', 10)).pack(anchor=tk.W)
            
            # Botón para enviar la tarea
            tarea_id = tarea[0]
            curso_id = tarea[1]
            btn_subir_tarea = tk.Button(second_frame, text="Mandar Tarea", bg='#007BFF', fg='white', font=('Arial', 10, 'bold'),
                                        command=lambda tarea_id=tarea_id, curso_id=curso_id: self.mandarTarea(conexion, tarea_id, curso_id, id_user))
            btn_subir_tarea.pack(anchor=tk.W, pady=10, padx=20)

    
    def mandarTarea(self, conexion, id_tarea, id_curso, id_user):
        # Crear la ventana para enviar la tarea
        ventanita = tk.Tk()
        ventanita.title("Mandar Tarea")
        ventanita.geometry("980x600")
        ventanita.configure(bg="black")  # Establecer fondo negro para la ventana
        
        # Etiqueta de título
        label_mandarTarea = tk.Label(ventanita, text="Mandar Tarea", bg="black", fg="white", font=('Arial', 16, 'bold'))
        label_mandarTarea.pack(pady=20)
        
        # Etiqueta para subir archivo
        label_subirArchivo = tk.Label(ventanita, text="Subir archivo:", bg="black", fg="white", font=('Arial', 12))
        label_subirArchivo.pack(pady=10)
        
        # Botón para abrir archivo
        boton_abrir = tk.Button(ventanita, text="Abrir archivo", bg='#007BFF', fg='white', font=('Arial', 12),
                                command=lambda: self.abrir_archivo(conexion))
        boton_abrir.pack(pady=10)
        
        # Etiqueta para dejar un comentario
        label_comentario = tk.Label(ventanita, text="Dejar un comentario:", bg="black", fg="white", font=('Arial', 12))
        label_comentario.pack(pady=10)
        
        # Entrada de texto para el comentario (utiliza tk.Text)
        self.entry_comentario = tk.Text(ventanita, height=5, width=60, bg='white', fg='black', font=('Arial', 12))
        self.entry_comentario.pack(pady=10)
        
        # Botón para mandar la tarea
        btn_subir_tarea = tk.Button(ventanita, text="Mandar tarea", bg='#28A745', fg='white', font=('Arial', 12, 'bold'),
                                    command=lambda: self.subir_tarea(conexion, id_tarea, id_curso, id_user))
        btn_subir_tarea.pack(pady=10)

        
    def subir_tarea(self, conexion, id_tarea, id_curso, id_user):
        archivo = psycopg2.Binary(self.contenido)
        comentario = self.entry_comentario.get("1.0", "end-1c")
        print(f"el tipo de comentario es: {type(comentario)}")
        conexion.entregarTarea(id_tarea, id_curso, id_user, archivo, comentario, self.id_tipoArchivo)
        messagebox.showinfo("Publicacion Exitosa")
        
    
    def abrir_archivo(self, conexion):
        ruta_archivo = filedialog.askopenfilename(title="Seleccionar archivo")
        if ruta_archivo:
            with open(ruta_archivo, "rb") as archivo:
                self.contenido = archivo.read()
                self.id_tipoArchivo = conexion.obteneridTipoArchivo(ruta_archivo)
                print(self.id_tipoArchivo)
            print(f"Archivo '{ruta_archivo}' abierto correctamente.")
        else:
            print("No se seleccionó ningún archivo.")
        
        
    
    def interfaz_verEntregas(self, id_user, conexion):
        entregas = conexion.obtenerTareasEntregadas(id_user)
        
        # Crear la ventana para mostrar las entregas
        ventanita = tk.Tk()
        ventanita.title("Entregas de Estudiantes")
        ventanita.geometry("980x600")
        ventanita.configure(bg='black')  # Establecer fondo negro para la ventana
        
        # Frame principal y canvas con scrollbar
        main_frame = Frame(ventanita, bg='black')
        main_frame.pack(fill=BOTH, expand=1)
        
        my_canvas = Canvas(main_frame, bg='black')
        my_canvas.pack(side=tk.LEFT, fill=BOTH, expand=1)
        
        my_scrollbar = ttk.Scrollbar(main_frame, orient=VERTICAL, command=my_canvas.yview)
        my_scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        
        my_canvas.configure(yscrollcommand=my_scrollbar.set)
        my_canvas.bind('<Configure>', lambda e: my_canvas.configure(scrollregion=my_canvas.bbox("all")))
        
        second_frame = Frame(my_canvas, bg='black')
        my_canvas.create_window((0, 0), window=second_frame, anchor=tk.NW)
        
        # Título de la sección
        label_titulo = tk.Label(second_frame, text="ENTREGAS DE ESTUDIANTES", bg='black', fg='white', font=('Arial', 16, 'bold'))
        label_titulo.pack(pady=20)
        
        # Mostrar cada entrega en la interfaz
        for entrega in entregas:
            # Título de la tarea
            tk.Label(second_frame, text=f"TÍTULO TAREA: {entrega[0]}", bg='black', fg='white', font=('Arial', 12)).pack(anchor=tk.W)
            
            # Estudiante que realizó la entrega
            tk.Label(second_frame, text=f"ESTUDIANTE: {entrega[1]}", bg='black', fg='white', font=('Arial', 10)).pack(anchor=tk.W)
            
            # Fecha y hora de la entrega
            tk.Label(second_frame, text=f"FECHA Y HORA DE ENTREGA: {entrega[2]}", bg='black', fg='white', font=('Arial', 10)).pack(anchor=tk.W)
            
            # Curso al que pertenece la tarea
            tk.Label(second_frame, text=f"CURSO: {entrega[7]}", bg='black', fg='white', font=('Arial', 10)).pack(anchor=tk.W)
            
            # Descripción de la tarea
            tk.Label(second_frame, text=f"DESCRIPCIÓN: {entrega[5]}", bg='black', fg='white', font=('Arial', 10)).pack(anchor=tk.W)
            
            # Entrada para ingresar la calificación
            label_calificacion = tk.Label(second_frame, text="PONER CALIFICACIÓN:", bg='black', fg='white', font=('Arial', 10))
            label_calificacion.pack(anchor=tk.W, pady=5)
            entry_calificacion = tk.Entry(second_frame, width=20)
            entry_calificacion.pack(anchor=tk.W)
            
            # Botón para descargar la tarea enviada
            btn_descargar = tk.Button(second_frame, text="Descargar Tarea Enviada", bg='#007BFF', fg='white', font=('Arial', 10, 'bold'),
                                      command=lambda archivo=entrega[3], formato=entrega[4]: self.descargarArchivo(archivo, formato))
            btn_descargar.pack(anchor=tk.W, pady=5)
            
            # Botón para calificar la tarea
            btn_calificacion = tk.Button(second_frame, text="Calificar", bg='#28A745', fg='white', font=('Arial', 10, 'bold'),
                                         command=lambda entregaTarea=entrega, calificacion=entry_calificacion: self.darCalificacion(conexion, entregaTarea, calificacion))
            btn_calificacion.pack(anchor=tk.W, pady=5)

        
        
    def darCalificacion(self, conexion, entrega, entryCalificacion):
        calificacion = entryCalificacion.get()
        print(f"calificacion la calificacion es: {type(calificacion)}")
        if calificacion != '':    
            id_tarea = entrega[6]
            id_curso = entrega[7]
            id_user = entrega[8]
            fecha = entrega[2]
            conexion.calificarEntrega(id_tarea, id_curso, id_user, fecha, calificacion)
            messagebox.showinfo("Exito", "Se califico la entrega")
        else:
            messagebox.showerror("Sin calificacion","No pusiste ninguna calificacion")
        
        
        
            
    def descargarArchivo(self, archivo, formato):
        ruta_guardar = filedialog.asksaveasfilename(defaultextension="", initialfile=f"*.{formato}", filetypes=[("Todos los archivos", "*.*")])
        if ruta_guardar:
            with open(ruta_guardar, "wb") as archivo_descarga:
                archivo_descarga.write(archivo)
        else:
            print("No se encontró el archivo con el ID proporcionado.")
        
                
    def verPlanilla(self):
        print("se vio las planillas :D")
        
            
Login()

