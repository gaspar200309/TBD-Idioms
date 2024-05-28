import sys
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QLineEdit, QPushButton, QVBoxLayout, QHBoxLayout
from PyQt5.QtGui import QPixmap, QFont
import psycopg2

class Login:
    
    def __init__(self):
        print("Hola mundo")
        self.connection = None
        self.cur = None
        self.connect()
        print("Hola mundo")

    def connect(self):
        print("Hola mundo")
        try:
            print("Hola mundo")
            self.connection = psycopg2.connect(
                host='localhost',
                user='gaspar',
                password='armando1gaspar',
                database='login'
            )
            print("Conexión exitosa")
            self.cur = self.connection.cursor()
            self.sacar_pid()  
        except Exception as ex:
            print(ex)
            print("Error en la conexión de la base de datos")

    def sacar_pid(self):
        try:
            self.cur.execute("SELECT pg_backend_pid();")
            last_pid_row = self.cur.fetchone()
            if last_pid_row:
                self.last_pid = last_pid_row[0] 
                print("PID obtenido:", self.last_pid)
            else:
                print("Algo falló al obtener el PID")
        except Exception as ex:
            print("Error al obtener el PID:", ex)

    def consulta_user(self, name, password):
        try:
            self.cur.execute("SELECT id, name, password	FROM public.user WHERE name = %s AND password = %s ", (name, password))
            user_data = self.cur.fetchone()
            if user_data:
                print("Usuario encontrado:", user_data)
                return user_data[0], True
            else:
                print("Usuario no encontrado")
                return None, False
        except Exception as ex:
            print("Error al consultar usuario:", ex)
            return None, False

    def insertar_datos(self, name, password):
        try:
            user_id, encontrado = self.consulta_user(name, password)
            if encontrado:
                self.cur.execute("INSERT INTO public.sesion(pid, username, id) VALUES(%s, %s, %s)", 
                                  (self.last_pid, name, user_id))
                self.connection.commit()
                print("Datos insertados correctamente para el usuario:", name)
            else:
                print("No se pudieron insertar los datos debido a un error previo para el usuario:", name)
            return user_id, encontrado
        except Exception as ex:
            print("Error al insertar datos:", ex)
            return None, False

    def cerrar_conexion(self):
        try:
            if self.cur:
                self.cur.close()
            if self.connection:
                self.connection.close()
            print("Conexión cerrada")
        except Exception as ex:
            print("Error al cerrar la conexión:", ex)

class LoginForm(QWidget):
    def _init_(self):
        super()._init_()
        self.initUI()

    def initUI(self):
        self.setWindowTitle('Iniciar sesión')
        self.setGeometry(600, 600, 600, 500)

        # Fondo de la ventana
        pixmap = QPixmap("fondo.png")
        background_label = QLabel(self)
        background_label.setPixmap(pixmap)
        background_label.setGeometry(0, 0, self.width(), self.height())
        
        layout = QVBoxLayout()

        # Nombre de usuario
        self.username_label = QLabel('Nombre de usuario:')
        self.username_label.setStyleSheet("color: white; font-size: 20px;")  # Cambiar color y tamaño de letra
        self.username_label.setStyleSheet("color: white; font-size: 16px;")
        self.username_input = QLineEdit()
        self.username_input.setMinimumWidth(200)  # Ajustar el ancho mínimo del QLineEdit
        layout.addWidget(self.username_label)
        layout.addWidget(self.username_input)

        # Contraseña
        self.password_label = QLabel('Contraseña:')
        self.password_label.setStyleSheet("color: white; font-size: 20px;")  
        self.password_input = QLineEdit()
        self.password_input.setEchoMode(QLineEdit.Password)
        self.password_input.setMinimumWidth(200)  # Ajustar el ancho mínimo del QLineEdit
        layout.addWidget(self.password_label)
        layout.addWidget(self.password_input)

        # Botones
        button_layout = QHBoxLayout()
        self.login_button = QPushButton('Aceptar')
        self.login_button.setStyleSheet("background-color: #4CAF50; color: white; font-size: 18px;")
        self.login_button.move(200, 300)
        self.cancel_button = QPushButton('Cancelar', self)
        self.cancel_button.setStyleSheet("background-color: #f44336; color: white; font-size: 18px;")
        self.cancel_button.move(300, 300)
        button_layout.addWidget(self.login_button)
        button_layout.addWidget(self.cancel_button)
        layout.addLayout(button_layout)

        # Área de texto para mostrar el resultado del inicio de sesión
        self.result_label = QLabel('')
        layout.addWidget(self.result_label)
        self.result_label.setStyleSheet("color: red; font-size: 18px;")
        self.result_label.move(200, 350)

        self.setLayout(layout)

        # Conectar botones a funciones
        self.login_button.clicked.connect(self.submit_login)
        self.cancel_button.clicked.connect(self.cancel_login)

    def submit_login(self):
        username = self.username_input.text()
        password = self.password_input.text()
        login = Login()
        user_id, encontrado = login.consulta_user(username, password)
        login.cerrar_conexion()

        # Actualizar el texto de la etiqueta de resultado según el resultado del inicio de sesión
        if encontrado:
            self.result_label.setText('Inicio de sesión exitoso')
        else:
            self.result_label.setText('Inicio de sesión fallido')

    def cancel_login(self):
        self.close()

if __name__ == '_main_':
    app = QApplication(sys.argv)
    login_form = LoginForm()
    login_form.show()
    sys.exit(app.exec_())
