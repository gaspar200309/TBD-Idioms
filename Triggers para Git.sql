SELECT id_clase, id_tarea, id_album, id_tipo_archivo, nombre_album
	FROM public.album;
	
CREATE OR REPLACE FUNCTION trg_clase_log() 
RETURNS TRIGGER
AS $$

	DECLARE 
		id_user VARCHAR;

BEGIN

	SELECT usuario.nombre INTO id_user  
		FROM sesion, usuario
			WHERE sesion.pid = pg_backend_pid() AND sesion.ci = usuario.ci;
	
    INSERT INTO LOGUSER (IDENTIFICACION, FECHAEVENTO, HORAEVENTO, DATO_NUEVO, DATO_VIEJO_, TABLA, EVENTO)
    VALUES (id_user, CURRENT_DATE, CURRENT_TIME, NEW, OLD, TG_TABLE_NAME, TG_OP);
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_registrar_cambios_Est
AFTER INSERT OR UPDATE OR DELETE
ON estudiante
FOR EACH ROW
EXECUTE FUNCTION trg_clase_log();

CREATE TRIGGER tr_registrar_cambios_doc
AFTER INSERT OR UPDATE OR DELETE
ON docente
FOR EACH ROW
EXECUTE FUNCTION trg_clase_log();

CREATE TRIGGER tr_registrar_cambios_Publicacion
AFTER INSERT OR UPDATE OR DELETE
ON entrega
FOR EACH ROW
EXECUTE FUNCTION trg_clase_log();

CREATE TRIGGER tr_registrar_cambios_Publicac
AFTER INSERT OR UPDATE OR DELETE
ON publicacion
FOR EACH ROW
EXECUTE FUNCTION trg_clase_log();

CREATE TRIGGER tr_registrar_cambios_tarea
AFTER INSERT OR UPDATE OR DELETE
ON tarea
FOR EACH ROW
EXECUTE FUNCTION trg_clase_log();

CREATE TRIGGER tr_registrar_cambios_entregatarea
AFTER INSERT OR UPDATE OR DELETE
ON entregatarea
FOR EACH ROW
EXECUTE FUNCTION trg_clase_log();

