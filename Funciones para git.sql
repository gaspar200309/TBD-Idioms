CREATE OR REPLACE FUNCTION verify_user (name_user VARCHAR, password_login VARCHAR)
RETURNS TABLE (ci INTEGER, nombre_completo VARCHAR)
LANGUAGE plpgsql
AS $$

	BEGIN
	RETURN QUERY
		SELECT 	usuario.ci, usuario.nombre
			
				FROM public.usuario
					WHERE nombre = name_user AND contrasena = password_login;
END;
$$;

SELECT * FROM verify_user ('Juan', 'juan123');


CREATE OR REPLACE FUNCTION public.recuperar_credenciales(
	ci_user integer)
	RETURNS TABLE (nombre_ui VARCHAR)
AS $$
BEGIN
	RETURN QUERY
	SELECT ui.nombre_ui
	FROM(SELECT funcio_ui.id_ui
			FROM (SELECT rol_funcion.id_funcion
				 FROM(SELECT usern_rol.id_rol
					 FROM(SELECT usuario.ci
							 from usuario
							 WHERE ci = ci_user)uno, usern_rol
					WHERE usern_rol.ci = uno.ci)dos, rol_funcion
				WHERE rol_funcion.id_rol= dos.id_rol)tres, funcio_ui
			WHERE funcio_ui.id_funcion = tres.id_funcion)cuatro, ui
	WHERE ui.id_ui = cuatro.id_ui;
END; 
$$ LANGUAGE plpgsql;

SELECT recuperar_credenciales (6);




CREATE OR REPLACE FUNCTION obtener_rol(id_usuario INTEGER)
RETURNS VARCHAR AS $$
DECLARE
    nombre_rol VARCHAR;
BEGIN
    SELECT rol.nombre_rol INTO nombre_rol
    FROM rol
    WHERE rol.id_rol = (
        SELECT usern_rol.id_rol
			FROM (SELECT usuario.ci
					FROM usuario
						WHERE ci = id_usuario
				) uno, usern_rol
       		WHERE usern_rol.ci = uno.ci
    );

    RETURN nombre_rol;
END;
$$ LANGUAGE plpgsql;


select obtener_rol(1);



CREATE OR REPLACE FUNCTION obtener_datos_personal(id_usuario INTEGER)
RETURNS TABLE(
    nombre VARCHAR,
    rol VARCHAR,
    correo VARCHAR,
    fecha_nacimiento DATE
) AS $$
BEGIN
    RETURN QUERY
    SELECT  dos.nombre, rol.nombre_rol, dos.correo, dos.fechanacimiento
	FROM (SELECT usern_rol.id_rol,uno.ci, uno.nombre, uno.correo, uno.fechanacimiento
			FROM (SELECT usuario.ci, usuario.nombre, usuario.correo, usuario.fechanacimiento
						FROM usuario
					WHERE usuario.ci = id_usuario)uno, usern_rol
			WHERE usern_rol.ci = uno.ci)dos, rol
	 WHERE rol.id_rol = dos.id_rol;
END;
$$ LANGUAGE plpgsql;


SELECT * from obtener_datos_personal (4);


-- Función para cerrar sesión
CREATE OR REPLACE FUNCTION cerrar_sesion(pid INT)
RETURNS VOID AS $$
BEGIN
    UPDATE sesion SET activos = FALSE WHERE sesion.pid = cerrar_sesion.pid;
END;
$$ LANGUAGE plpgsql;


SELECT ci, id_sesion, pid, fecha_sesion, activos
FROM public.sesion;
	
SELECT cerrar_sesion(123);



CREATE OR REPLACE FUNCTION obtener_cursos(id_user INT)
RETURNS TABLE (
    id_clase INTEGER,
    nombre_clase VARCHAR(50)
) AS $$
BEGIN
    RETURN QUERY
    SELECT curso.id_clase, curso.nombre_clase
    	FROM curso
    		WHERE ci = id_user;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM obtener_cursos(1);


CREATE OR REPLACE FUNCTION crear_tarea(
    IN id_curso_par INT,
    IN fecha_limite_param DATE,
    IN titulo_param VARCHAR(50),
    IN descripcion_param VARCHAR(250)
)
RETURNS VOID AS $$
DECLARE
    id_tarea INTEGER;
BEGIN
    SELECT nextval('tarea_id_tarea_seq') INTO id_tarea;
    
    INSERT INTO TAREA (ID_CLASE, ID_TAREA, FECHA_LIMITE_, TITULO_TAREA)
        VALUES(id_curso_par, id_tarea, fecha_limite_param, titulo_param);
        
    INSERT INTO PUBLICACION (ID_CLASE, ID_TAREA, FECHA_PUBLICACION, DESCRIPCION)
        VALUES(id_curso_par, id_tarea, CURRENT_DATE, descripcion_param);
END;
$$ LANGUAGE plpgsql;

SELECT crear_tarea(1, '2024-05-05', 'Tarea2', 'Esta tarea debe ser entregado mañana');


CREATE OR REPLACE FUNCTION obtener_tareas_asignadas (id_user INTEGER)
RETURNS TABLE(id_tarea INTEGER, 
			  id_clase INTEGER, 
			  fecha_publicado DATE, 
			  fecha_limite DATE, 
			  titulo_tarea VARCHAR,
			  descripcion VARCHAR,
			  nombre_clase VARCHAR)
AS $$
BEGIN 
	RETURN QUERY
	SELECT tres.id_tarea, tres.id_clase, publicacion.fecha_publicacion, tres.fecha_limite_, tres.titulo_tarea, publicacion.descripcion, tres.nombre_clase
		FROM (SELECT tarea.id_tarea, tarea.fecha_limite_, tarea.titulo_tarea, dos.id_clase, dos.nombre_clase
			FROM(SELECT curso.id_clase, curso.nombre_clase
				FROM( SELECT inscrito.id_clase
					FROM inscrito
						WHERE inscrito.ci = id_user) uno, curso
				 WHERE curso.id_clase = uno.id_clase )dos, tarea
			 WHERE tarea.id_clase = dos.id_clase)tres, publicacion
		 WHERE publicacion.id_tarea = tres.id_tarea;
END;
$$ LANGUAGE plpgsql;

select * from obtener_tareas_asignadas(4);


CREATE OR REPLACE FUNCTION entregar_tarea(
	id_tarea_elegido INTEGER, 
	id_curso_elegido INTEGER, 
	id_user_elegido INTEGER, 
	archivo_enviado BYTEA, 
	comentario_elegido VARCHAR, 
	idTipoArchivo INTEGER)
RETURNS VOID
AS $$
	DECLARE
    id_entrega INTEGER;

BEGIN

	SELECT nextval('entrega_id_entrega_seq') INTO id_entrega;
	
		INSERT INTO public.entrega(
			ci, nota, id_entrega, comentario)
			VALUES (id_user_elegido, 0, id_entrega, comentario_elegido);

		INSERT INTO public.entregatarea(
			ci, id_entrega, tar_id_clase, id_tarea, fecha_publicacion)
			VALUES (id_user_elegido, id_entrega, id_curso_elegido, id_tarea_elegido, CURRENT_DATE);

		INSERT INTO public.album(
			id_clase, id_tarea, nombre_album, id_tipo_archivo)
			VALUES (id_curso_elegido, id_tarea_elegido, archivo_enviado, idTipoArchivo);	
END;
$$ LANGUAGE plpgsql;


CREATE SEQUENCE entrega_id_entrega_seq;
CREATE SEQUENCE tarea_id_tarea_seq START 1;




CREATE OR REPLACE FUNCTION public.obtener_tareas_entregadas(IN id_user_elegido integer)
    RETURNS TABLE(titulo character varying,
				  nombreestudiante character varying, 
				  fecha date, 
				  archivo bytea, 
				  formato VARCHAR, 
				  descripcion VARCHAR, 
				  id_tarea integer, 
				  id_curso integer, 
				  id_user integer)
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100    ROWS 1000 
    
AS $BODY$
	
BEGIN
	RETURN QUERY
	SELECT seis.titulo_tarea, usuario.nombre, seis.fecha_publicacion, seis.nombre_album, seis.extencion, seis.comentario, seis.id_tarea, seis.id_clase, usuario.ci
		FROM (SELECT entrega.comentario, entrega.ci, cinco.extencion, cinco.nombre_album, cinco.fecha_publicacion, cinco.id_tarea, cinco.titulo_tarea, cinco.id_clase
			FROM (SELECT tipo_archivo.extencion, cuatro.nombre_album, cuatro.fecha_publicacion, cuatro.id_entrega, cuatro.id_tarea, cuatro.titulo_tarea, cuatro.id_clase
				FROM (SELECT album.id_tipo_archivo, album.nombre_album, tres.fecha_publicacion, tres.id_entrega, tres.id_tarea, tres.titulo_tarea, tres.id_clase
					FROM (SELECT entregatarea.fecha_publicacion, entregatarea.id_entrega, dos.id_tarea, dos.titulo_tarea, dos.id_clase
							FROM (SELECT tarea.id_tarea, tarea.titulo_tarea, uno.id_clase
								FROM(SELECT curso.id_clase
										FROM curso
									WHERE curso.ci = id_user_elegido )uno, tarea
							 WHERE tarea.id_clase = uno.id_clase)dos, entregatarea
						WHERE entregatarea.id_tarea = dos.id_tarea)tres, album
					WHERE album.id_tarea = tres.id_tarea)cuatro, tipo_archivo
				WHERE tipo_archivo.id_tipo_archivo = cuatro.id_tipo_archivo)cinco, entrega
			WHERE entrega.id_entrega = cinco.id_entrega)seis, usuario
		WHERE usuario.ci = seis.ci;
			
END;
$BODY$;

select * from obtener_tareas_entregadas(1)



CREATE OR REPLACE FUNCTION calificar_tarea(id_tarea_elegido INTEGER, id_curso_elegido INTEGER, id_user_elegido INTEGER, fecha DATE, calificacion NUMERIC)
RETURNS VOID
AS $$
	
BEGIN
	 	UPDATE ENTREGA
		SET calificacion = calificacion
		WHERE id_tarea = id_tarea_elegido and id_curso = id_curso_elegido 
		and ci = id_user_elegido and fecha_hora = fecha;	
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION public.calificar_entrega(
    IN p_id_tarea INT,
    IN p_id_curso INT,
    IN p_id_user INT,
    IN p_fecha DATE,
    IN p_calificacion INT
)
RETURNS VOID
AS $$
DECLARE
        v_id_entrega INT;
BEGIN
        SELECT ID_ENTREGA
        INTO v_id_entrega
        FROM ENTREGATAREA
        WHERE ID_TAREA = p_id_tarea
          AND TAR_ID_CLASE = p_id_curso
          AND CI = p_id_user;
		  
            UPDATE ENTREGA
            SET NOTA = p_calificacion
            WHERE ID_ENTREGA = v_id_entrega
              AND CI = p_id_user;
       
    END;
$$ LANGUAGE plpgsql;
