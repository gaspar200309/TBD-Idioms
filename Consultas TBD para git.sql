-----Cantidad de anuncios publicados por cada docente en un día específico---


select Count (*) from (
	select tarea.titulo_tarea, dos.nombre_clase, dos.ci, dos.id_clase, tarea.id_tarea
		from (select curso.ci, curso.id_clase, curso.nombre_clase 
			from (select docente.ci 
				from docente 
				where docente.ci = 1)uno, curso
			where uno.ci = curso.ci)dos, tarea
		where dos.id_clase = tarea.id_clase)tres, publicacion
	where publicacion.id_tarea = tres.id_tarea;

---Promedio de las notas de un estudiante-----
SELECT AVG(entrega.nota) AS PromedioNota FROM (
	SELECT estudiante.ci FROM (
		SELECT inscrito.ci 
			FROM inscrito
		WHERE inscrito.ci = 4)uno, Estudiante
	WHERE estudiante.ci = uno.ci)dos, entrega
WHERE dos.ci = entrega.ci


---Cursos con la mayor cantidad de inscripciones en un período específico---
SELECT CUR.NOMBRE_CLASE, (
    SELECT COUNT(*)
    FROM INSCRITO INS
    WHERE INS.ID_CLASE = CUR.ID_CLASE
    ) AS CANTIDAD_INSCRIPCIONES
FROM CURSO CUR;

-----Promedio de calificaciones por curso 
SELECT CUR.NOMBRE_CLASE, (
    SELECT AVG(ENT.NOTA)
    FROM ENTREGA ENT
    JOIN ENTREGATAREA ETA ON ETA.CI = ENT.CI AND ETA.ID_ENTREGA = ENT.ID_ENTREGA
    WHERE ETA.TAR_ID_CLASE = CUR.ID_CLASE
    ) AS PROMEDIO_CALIFICACION
FROM CURSO CUR;

---Entregas calificadas por el docente-----------	
	select cuatro.titulo_tarea, entrega.comentario, entrega.nota 
		from (select tres.titulo_tarea, entregatarea.id_entrega 
			  from (select tarea.id_tarea,tarea.titulo_tarea
					from (select curso.id_clase
						from (select ci
								from Docente
							where ci=1) uno, curso
						where curso.ci=uno.ci) dos, Tarea
					where tarea.id_clase=dos.id_clase)tres, entregatarea
				where tres.id_tarea = entregatarea.id_tarea)cuatro, entrega
		where cuatro.id_entrega = entrega.id_entrega and nota != 0
		

----Consulta para encontrar los usuarios con la mayor cantidad de roles asignados:
SELECT ur.ci, COUNT(*) AS Cantidad_Roles
FROM USERN_ROL ur
GROUP BY ur.ci


---Promedio del estudiante de la materia X--------
	SELECT Estudiante.nombreEst,Estudiante.siss,AVG(Entrega.calificacion) AS promedio
		FROM Estudiante,Entrega
		WHERE Estudiante.siss = Entrega.siss and 
				Entrega.id_tarea in (SELECT id_tarea
									From Tarea
									Where numero = 3)
		GROUP BY Estudiante.nombreEst,Estudiante.siss
		
-----LogUser del User--------
SELECT fechaEvento,horaEvento,tabla,Evento from Loguser
where identificacion = 'Marcelo Flores'

---------Consulta para obtener el promedio de calificaciones por grupo:------
		SELECT dos.nombreMateria,AVG(Entrega.calificacion) AS Promedio_grupo
		FROM(Select Tarea.id_tarea,uno.nombreMateria,uno.numero
			FROM (Select nombreMateria,numero
	 			FROM Grupo
	 			where numero = 3) uno, Tarea
	 		where uno.numero = Tarea.numero)dos, Entrega
		WHERE Entrega.id_tarea = dos.id_tarea
		GROUP BY dos.nombreMateria

--Consulta para encontrar los grupos con la mayor cantidad de inscripciones en un período específico:
SELECT i.ID_USER,i.ci i.NUMERO, COUNT(*) AS Cantidad_Inscripciones
FROM INSCRIPCION i
WHERE i.FECHAINSCRIPCION BETWEEN '2024-04-05' AND '2024-04-31'  -- Período específico
GROUP BY i.ID_USER, i.CI, i.NUMERO
---Consulta para obtener el número total de tareas entregadas por cada estudiante:
		select uno.nombreEst, COUNT(*) AS Total_entregas
		FROM(SELECT id_user, nombre 
				FROM Estudiante
				WHERE id_user=4)uno, Entrega
		WHERE uno.id_user=Entrega.est_id_user
		Group by uno.nombreEst

---Consulta para obtener el promedio de calificaciones por tarea:
SELECT Tarea.tituloTarea,AVG(Entrega.calificacion) as promedio_calificaciones 
FROM Entrega,Tarea
WHERE Entrega.id_tarea = Tarea.id_tarea
Group BY Tarea.tituloTarea
select * 
from (select entregatarea.id_tarea, entregatarea.id_tarea
	from (select tarea.id_tarea
		  from tarea)uno, entregatarea
		where  entregatarea.id_tarea =  uno.id_tarea)dos, entrega
	where entrega.id_entrega

----Consulta para encontrar los usuarios con la mayor cantidad de roles asignados:
SELECT ur.ci, COUNT(*) AS Cantidad_Roles
FROM USERN_ROL ur
GROUP BY ur.ci

SELECT seis.titulo_tarea
FROM (
    SELECT entrega.comentario, entrega.ci, cinco.extencion, cinco.nombre_album, cinco.fecha_publicacion, cinco.id_tarea, cinco.titulo_tarea, cinco.id_clase
    FROM (
        SELECT tipo_archivo.extencion, cuatro.nombre_album, cuatro.fecha_publicacion, cuatro.id_entrega, cuatro.id_tarea, cuatro.titulo_tarea, cuatro.id_clase
        FROM (
            SELECT album.id_tipo_archivo, album.nombre_album, tres.fecha_publicacion, tres.id_entrega, tres.id_tarea, tres.titulo_tarea, tres.id_clase
            FROM (
                SELECT entregatarea.fecha_publicacion, entregatarea.id_entrega, dos.id_tarea, dos.titulo_tarea, dos.id_clase
                FROM (
                    SELECT tarea.id_tarea, tarea.titulo_tarea, uno.id_clase
                    FROM (
                        SELECT curso.id_clase
                        FROM curso
                        WHERE curso.ci = (
                            SELECT ci, nombre
                            FROM usuario
                            WHERE nombre = 'Ana'
                        )
                    ) uno, tarea
                    WHERE tarea.id_clase = uno.id_clase
                ) dos, entregatarea
                WHERE entregatarea.id_tarea = dos.id_tarea
            ) tres, album
            WHERE album.id_tarea = tres.id_tarea
        ) cuatro, tipo_archivo
        WHERE tipo_archivo.id_tipo_archivo = cuatro.id_tipo_archivo
    ) cinco, entrega
    WHERE entrega.id_entrega = cinco.id_entrega
) seis, usuario
WHERE usuario.ci = seis.ci;

----Entregas calificadas por el docente----
SELECT DOC.ASIGNATURA, (
    SELECT COUNT(*)	
    FROM ENTREGA ENT
    WHERE ENT.CI = DOC.CI
    ) AS CANTIDAD_ENTREGAS_CALIFICADAS
FROM DOCENTE DOC;

Select * from 



