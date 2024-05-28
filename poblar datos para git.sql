
-- Insertar tipos de archivo en la tabla Tipo_Archivo
INSERT INTO Tipo_Archivo (extencion) VALUES ('pdf');
INSERT INTO Tipo_Archivo (extencion) VALUES ('jpg');
INSERT INTO Tipo_Archivo (extencion) VALUES ('png');
INSERT INTO Tipo_Archivo (extencion) VALUES ('docx');
INSERT INTO Tipo_Archivo (extencion) VALUES ('xlsx');
INSERT INTO Tipo_Archivo (extencion) VALUES ('pptx');


-- Ejemplo de inserción de datos simulados para la tabla USUARIO
INSERT INTO USUARIO (CI, NOMBRE, APELLIDO, CORREO, CONTRASENA, FECHANACIMIENTO)
VALUES
	(1, 'Juan', 'Perez', 'juanperez@gmail.com', 'juan123', '1985-09-20' ),
    (2, 'María', 'Gómez', 'maria.gomez@example.com', 'clave456', '1985-09-20'),
	(3, 'Carlos', 'López', 'carlos.lopez@example.com', 'password789', '1982-03-10'),
	(4, 'Ana', 'Martínez', 'ana.martinez@example.com', 'ana123', '1992-07-25'),
	(5, 'Pedro', 'Rodríguez', 'pedro.rodriguez@example.com', 'clave123', '1988-12-18'),
	(6, 'Laura', 'Sánchez', 'laura.sanchez@example.com', 'password456', '1993-04-30');


-- Ejemplo de inserción de datos simulados para la tabla CARRERA
INSERT INTO CARRERA (ID_CARRERA, NOMBRECARRERA)
VALUES
    (1, 'Ingeniería Informática'),
    (2, 'Ingeniaria en Sistemas'),
    (3, 'Derecho');
	
-- Ejemplo de inserción de datos simulados para la tabla DOCENTE
INSERT INTO DOCENTE (CI, ASIGNATURA)
VALUES
    (1, 'Base de Datos'),
    (2, 'Programación'),
    (3, 'Derecho Penal');
	(4, 'Base de Datos'),
    (5, 'Programación'),
    (6, 'Derecho Penal');

-- Ejemplo de inserción de datos simulados para la tabla CURSO
INSERT INTO CURSO (ID_CLASE, CI, NOMBRE_CLASE)
VALUES
    (1, 1, 'Base de Datos'),
    (2, 2, 'Programación Avanzada'),
    (3, 3, 'Derecho Constitucional');
	(4, 4, 'Base de Datos'),
    (5, 5, 'Programación Avanzada'),
    (6, 6, 'Derecho Constitucional');
	

-- Ejemplo de inserción de datos simulados para la tabla ESTUDIANTE
INSERT INTO ESTUDIANTE (CI, SEMESTRE, CODIGOSIS)
VALUES
    (4, 'Quinto Semestre', 'E1234'),
    (5, 'Octavo Semestre', 'E5678'),
    (6, 'Tercer Semestre', 'E91011');
	(1, 'Quinto Semestre', 'E1234'),
    (2, 'Octavo Semestre', 'E5678'),
    (3, 'Tercer Semestre', 'E91011');


-- Ejemplo de inserción de datos simulados para la tabla ROL
INSERT INTO ROL (ID_ROL, NOMBRE_ROL, ACTIVEROL)
VALUES
    (1, 'Estudiante', true),
    (2, 'Docente', true),
    (3, 'Administrador', true);

-- Ejemplo de inserción de datos simulados para la tabla USERN_ROL
INSERT INTO USERN_ROL (CI, ID_ROL, FECHA_ACTIVACION)
VALUES
    (1, 2, '2024-04-20'),
	(2, 2, '2024-04-20'),
	(3, 2, '2024-04-20'),
	(4, 1, '2024-04-20'),
	(5, 1, '2024-04-20'),
	(6, 1, '2024-04-20');

-- Ejemplo de inserción de datos simulados para la tabla FUNCION
INSERT INTO FUNCION (ID_FUNCION, NOMBRE_FUNCION, ACTIVOF)
VALUES
    (1, 'Dar tarea', true),
	(2, 'ver entregas', true),
	(3, 'ver planilla', true),
	(4, 'subir tarea', true),
	(5, 'ver notas', true),
	(6, 'ver materias inscritas', true);
	
-- Ejemplo de inserción de datos simulados para la tabla UI
INSERT INTO UI (ID_UI, NOMBRE_UI, ACTIVO)
VALUES
    (1, 'Dar tarea', true),
	(2, 'ver entregas', true),
	(3, 'ver planilla', true),
	(4, 'subir tarea', true),
	(5, 'ver notas', true),
	(6, 'ver materias inscritas', true);

-- Ejemplo de inserción de datos simulados para la tabla FUNCIO_UI
INSERT INTO FUNCIO_UI (ID_UI, ID_FUNCION, FECHA_INICIO)
VALUES
    (1, 1, '2024-04-20'),
	(2, 2, '2024-04-20'),
	(3, 3, '2024-04-20'),
	(4, 4, '2024-04-20'),
	(5, 5, '2024-04-20'),
	(6, 6, '2024-04-20');

-- Ejemplo de inserción de datos simulados para la tabla ROL_FUNCION
INSERT INTO ROL_FUNCION (ID_FUNCION, ID_ROL, FECHA_ACTROL)
VALUES
    (1, 2, '2024-04-20'),
	(2, 2, '2024-04-20'),
	(3, 2, '2024-04-20'),
	(4, 1, '2024-04-20'),
	(5, 1, '2024-04-20'),
	(6, 1, '2024-04-20');--Esta tabla es la mas importante para dar funciones a otros roles


-- Ejemplo de inserción de datos simulados para la tabla INSCRITO
INSERT INTO INSCRITO (ID_CLASE, CI, ID_CARRERA)
VALUES
    (1, 4, 1),
    (2, 5, 2),
    (3, 6, 3);
	(1, 1, 1),
    (2, 2, 2),
    (3, 3, 3);
	
	

	
--#################################################################
--Tablas extras para la aplicacion----


-- Ejemplo de inserción de datos simulados para la tabla ENTREGA
INSERT INTO ENTREGA (CI, NOTA, ID_ENTREGA)
VALUES
    (6, 85, 1),
    (5, 92, 2),
    (4, 78, 3); --Primera tabla en ser insertada para entregar una tarea
	
	
-- Ejemplo de inserción de datos simulados para la tabla TAREA
INSERT INTO TAREA (ID_CLASE, ID_TAREA, FECHA_LIMITE_, DESCRIPCION_TAREA, TITULO_TAREA)
VALUES
    (10, 1, '2024-05-05', 'Realizar presentación sobre Base de Datos', 'Presentación Base de Datos'),
    (20, 2, '2024-05-10', 'Entregar informe final de Proyecto de Programación', 'Informe Proyecto de Programación'),
    (30, 3, '2024-04-30', 'Resolver casos prácticos de Derecho Constitucional', 'Casos Prácticos de Derecho');

---Segunda tabla independiente que debe ser insertada

-- Ejemplo de inserción de datos simulados para la tabla ALBUM
INSERT INTO ALBUM (ID_CLASE, ID_TAREA, NOMBRE_ALBUM)
VALUES
    (10, 1, 'Álbum de Fotos de Clase 101'),
    (20, 2, 'Álbum de Proyectos de Clase 102'),
    (30, 3, 'Álbum de Actividades de Clase 103'); --Esta tabla depende de la tabla tarea 



-- Ejemplo de inserción de datos simulados para la tabla ENTREGATAREA
INSERT INTO ENTREGATAREA (CI, TAR_ID_CLASE, ID_TAREA, FECHA_PUBLICACION)
VALUES
    (6, 1, 1, '2024-04-20'),
    (5, 2, 2, '2024-04-25'),
    (4, 3, 3, '2024-04-22'); --Ultima tabla que debe ser insertada
	


insert into PUBLICACION (ID_PUBLICACION, ID_CLASE, ID_TAREA, FECHA_PUBLICACION, DESCRIPCION) values
(1, 1, 1, '2024-05-01', 'Se ha publicado el enunciado del proyecto final'),
(2, 2, 2, '2024-04-28', 'Se ha publicado el modelo relacional del proyecto'),
(3, 3, 3, '2024-04-25', 'Se ha publicado el enunciado del trabajo práctico'); --Ultima tabla en ser llenada 

--###########################################################
--Tablas extras probadas


-- Ejemplo de inserción de datos simulados para la tabla LOGUSER
INSERT INTO LOGUSER (IDENTIFICACION, FECHAEVENTO, HORAEVENTO, DATO_NUEVO, DATO_VIEJO_, TABLA, EVENTO)
VALUES
    ('12345678', '2024-04-25', '12:30:00', 'Nuevo valor', 'Valor anterior', 'Tabla Ejemplo', 'Actualización');

-- Insertar datos en la tabla SESION
INSERT INTO SESION (CI, ID_SESION, PID, FECHA_SESION, ACTIVOS, NOMBRE_USUARIO ) VALUES
(2, 2, 1002, '2024-04-21', true, 'Maria'),
(6, 3, 1003, '2024-04-21', true, 'Pedro');



