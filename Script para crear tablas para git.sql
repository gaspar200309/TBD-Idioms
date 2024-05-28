/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     29/4/2024 00:52:53                           */
/*==============================================================*/

/*==============================================================*/
/* Table: ALBUM                                                 */
/*==============================================================*/
create table ALBUM (
   ID_CLASE             INT4                 not null,
   ID_TAREA             INT4                 not null,
   ID_ALBUM             SERIAL               not null,
   ID_TIPO_ARCHIVO      INT4                 null,
   NOMBRE_ALBUM         CHAR(500)            not null,
   constraint PK_ALBUM primary key (ID_CLASE, ID_TAREA, ID_ALBUM)
);

/*==============================================================*/
/* Index: ALBUM_PK                                              */
/*==============================================================*/
create unique index ALBUM_PK on ALBUM (
ID_CLASE,
ID_TAREA,
ID_ALBUM
);

/*==============================================================*/
/* Index: ESTA_UN_FK                                            */
/*==============================================================*/
create  index ESTA_UN_FK on ALBUM (
ID_CLASE,
ID_TAREA
);

/*==============================================================*/
/* Index: TIENE_FK                                              */
/*==============================================================*/
create  index TIENE_FK on ALBUM (
ID_TIPO_ARCHIVO
);

/*==============================================================*/
/* Table: CARRERA                                               */
/*==============================================================*/
create table CARRERA (
   ID_CARRERA           INT4                 not null,
   NOMBRECARRERA        CHAR(50)             not null,
   constraint PK_CARRERA primary key (ID_CARRERA)
);

/*==============================================================*/
/* Index: CARRERA_PK                                            */
/*==============================================================*/
create unique index CARRERA_PK on CARRERA (
ID_CARRERA
);

/*==============================================================*/
/* Table: CURSO                                                 */
/*==============================================================*/
create table CURSO (
   ID_CLASE             INT4                 not null,
   CI                   INT4                 null,
   NOMBRE_CLASE         CHAR(50)             not null,
   constraint PK_CURSO primary key (ID_CLASE)
);

/*==============================================================*/
/* Index: CURSO_PK                                              */
/*==============================================================*/
create unique index CURSO_PK on CURSO (
ID_CLASE
);

/*==============================================================*/
/* Index: DICTA_FK                                              */
/*==============================================================*/
create  index DICTA_FK on CURSO (
CI
);

/*==============================================================*/
/* Table: DOCENTE                                               */
/*==============================================================*/
create table DOCENTE (
   CI                   INT4                 not null,
   ASIGNATURA           CHAR(50)             not null,
   constraint PK_DOCENTE primary key (CI)
);

/*==============================================================*/
/* Index: DOCENTE_PK                                            */
/*==============================================================*/
create unique index DOCENTE_PK on DOCENTE (
CI
);

/*==============================================================*/
/* Table: ENTREGA                                               */
/*==============================================================*/
create table ENTREGA (
   ID_ENTREGA           INT4                 not null,
   CI                   INT4                 not null,
   NOTA                 INT4                 null,
   COMENTARIO           VARCHAR(50)          not null,
   constraint PK_ENTREGA primary key (CI, ID_ENTREGA)
);

ALTER TABLE ENTREGA
ADD CONSTRAINT CHK_CALIFICACION
CHECK (NOTA >= 0 AND NOTA <= 100);


/*==============================================================*/
/* Index: ENTREGA_PK                                            */
/*==============================================================*/
create unique index ENTREGA_PK on ENTREGA (
CI,
ID_ENTREGA
);

/*==============================================================*/
/* Index: ENTREGA_FK                                            */
/*==============================================================*/
create  index ENTREGA_FK on ENTREGA (
CI
);

/*==============================================================*/
/* Table: ENTREGATAREA                                          */
/*==============================================================*/
create table ENTREGATAREA (
   CI                   INT4                 not null,
   ID_ENTREGA           INT4                 not null,
   TAR_ID_CLASE         INT4                 not null,
   ID_TAREA             INT4                 not null,
   FECHA_PUBLICACION    DATE                 not null,
   constraint PK_ENTREGATAREA primary key (CI, ID_ENTREGA, TAR_ID_CLASE, ID_TAREA, FECHA_PUBLICACION)
);

/*==============================================================*/
/* Index: ENTREGATAREA_PK                                       */
/*==============================================================*/
create unique index ENTREGATAREA_PK on ENTREGATAREA (
CI,
ID_ENTREGA,
TAR_ID_CLASE,
ID_TAREA,
FECHA_PUBLICACION
);

/*==============================================================*/
/* Index: ESTARA_ENTREGADA_FK                                   */
/*==============================================================*/
create  index ESTARA_ENTREGADA_FK on ENTREGATAREA (
TAR_ID_CLASE,
ID_TAREA
);

/*==============================================================*/
/* Index: SERA_ENTREGADA_FK                                     */
/*==============================================================*/
create  index SERA_ENTREGADA_FK on ENTREGATAREA (
CI,
ID_ENTREGA
);

/*==============================================================*/
/* Table: ESTUDIANTE                                            */
/*==============================================================*/
create table ESTUDIANTE (
   CI                   INT4                 not null,
   SEMESTRE             CHAR(50)             not null,
   CODIGOSIS            CHAR(50)             not null,
   constraint PK_ESTUDIANTE primary key (CI)
);

/*==============================================================*/
/* Index: ESTUDIANTE_PK                                         */
/*==============================================================*/
create unique index ESTUDIANTE_PK on ESTUDIANTE (
CI
);

/*==============================================================*/
/* Table: FUNCION                                               */
/*==============================================================*/
create table FUNCION (
   ID_FUNCION           SERIAL               not null,
   NOMBRE_FUNCION       VARCHAR(50)          not null,
   ACTIVOF              BOOL                 not null,
   constraint PK_FUNCION primary key (ID_FUNCION)
);

/*==============================================================*/
/* Index: FUNCION_PK                                            */
/*==============================================================*/
create unique index FUNCION_PK on FUNCION (
ID_FUNCION
);

/*==============================================================*/
/* Table: FUNCIO_UI                                             */
/*==============================================================*/
create table FUNCIO_UI (
   ID_UI                INT4                 not null,
   ID_FUNCION           INT4                 not null,
   FECHA_INICIO         DATE                 not null,
   constraint PK_FUNCIO_UI primary key (ID_UI, ID_FUNCION, FECHA_INICIO)
);

/*==============================================================*/
/* Index: FUNCIO_UI_PK                                          */
/*==============================================================*/
create unique index FUNCIO_UI_PK on FUNCIO_UI (
ID_UI,
ID_FUNCION,
FECHA_INICIO
);

/*==============================================================*/
/* Index: TIENE2_FK                                             */
/*==============================================================*/
create  index TIENE2_FK on FUNCIO_UI (
ID_FUNCION
);

/*==============================================================*/
/* Index: ESTA2_FK                                              */
/*==============================================================*/
create  index ESTA2_FK on FUNCIO_UI (
ID_UI
);

/*==============================================================*/
/* Table: INSCRITO                                              */
/*==============================================================*/
create table INSCRITO (
   ID_CLASE             INT4                 not null,
   CI                   INT4                 not null,
   ID_CARRERA           INT4                 null,
   constraint PK_INSCRITO primary key (ID_CLASE)
);

/*==============================================================*/
/* Index: INSCRITO_PK                                           */
/*==============================================================*/
create unique index INSCRITO_PK on INSCRITO (
ID_CLASE
);

/*==============================================================*/
/* Index: SE_INSCRIBIO_FK                                       */
/*==============================================================*/
create  index SE_INSCRIBIO_FK on INSCRITO (
CI
);

/*==============================================================*/
/* Index: PERTENECE_FK                                          */
/*==============================================================*/
create  index PERTENECE_FK on INSCRITO (
ID_CARRERA
);

/*==============================================================*/
/* Table: PUBLICACION                                           */
/*==============================================================*/
create table PUBLICACION (
   ID_CLASE             INT4                 not null,
   ID_TAREA             INT4                 not null,
   ID_PUBLICACION       SERIAL               not null,
   FECHA_PUBLICACION    DATE                 not null,
   DESCRIPCION          VARCHAR(250)         not null,
   constraint PK_PUBLICACION primary key (ID_CLASE, ID_TAREA, ID_PUBLICACION)
);

ALTER TABLE PUBLICACION
ADD CONSTRAINT CHK_FECHA_PUBLICACION
CHECK (FECHA_PUBLICACION <= CURRENT_DATE); 



/*==============================================================*/
/* Index: PUBLICACION_PK                                        */
/*==============================================================*/
create unique index PUBLICACION_PK on PUBLICACION (
ID_CLASE,
ID_TAREA,
ID_PUBLICACION
);

/*==============================================================*/
/* Index: ES_PUBLICADA_FK                                       */
/*==============================================================*/
create  index ES_PUBLICADA_FK on PUBLICACION (
ID_CLASE,
ID_TAREA
);

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
create table ROL (
   ID_ROL               SERIAL               not null,
   NOMBRE_ROL           VARCHAR(50)          not null,
   ACTIVEROL            BOOL                 not null,
   constraint PK_ROL primary key (ID_ROL)
);

/*==============================================================*/
/* Index: ROL_PK                                                */
/*==============================================================*/
create unique index ROL_PK on ROL (
ID_ROL
);

/*==============================================================*/
/* Table: ROL_FUNCION                                           */
/*==============================================================*/
create table ROL_FUNCION (
   ID_FUNCION           INT4                 not null,
   ID_ROL               INT4                 not null,
   FECHA_ACTROL         DATE                 not null,
   constraint PK_ROL_FUNCION primary key (ID_FUNCION, ID_ROL, FECHA_ACTROL)
);

/*==============================================================*/
/* Index: ROL_FUNCION_PK                                        */
/*==============================================================*/
create unique index ROL_FUNCION_PK on ROL_FUNCION (
ID_FUNCION,
ID_ROL,
FECHA_ACTROL
);

/*==============================================================*/
/* Index: ES_FK                                                 */
/*==============================================================*/
create  index ES_FK on ROL_FUNCION (
ID_ROL
);

/*==============================================================*/
/* Index: TIENE1_FK                                             */
/*==============================================================*/
create  index TIENE1_FK on ROL_FUNCION (
ID_FUNCION
);

/*==============================================================*/
/* Table: SESION                                                */
/*==============================================================*/
create table SESION (
   CI                   INT4                 not null,
   ID_SESION            SERIAL               not null,
   PID                  INT4                 not null,
   FECHA_SESION         DATE                 not null,
   ACTIVOS              BOOL                 not null,
   NOMBRE_USUARIO       VARCHAR(50)          not null,
   constraint PK_SESION primary key (CI, ID_SESION)
);

/*==============================================================*/
/* Index: SESION_PK                                             */
/*==============================================================*/
create unique index SESION_PK on SESION (
CI,
ID_SESION
);

/*==============================================================*/
/* Index: A_FK                                                  */
/*==============================================================*/
create  index A_FK on SESION (
CI
);

/*==============================================================*/
/* Table: TAREA                                                 */
/*==============================================================*/
create table TAREA (
   ID_CLASE             INT4                 not null,
   FECHA_LIMITE_        DATE                 not null,
   DESCRIPCION_TAREA    VARCHAR(50)          not null,
   TITULO_TAREA         VARCHAR(50)          not null,
   ID_TAREA             INT4                 not null,
   constraint PK_TAREA primary key (ID_CLASE, ID_TAREA)
);

/*==============================================================*/
/* Index: TAREA_PK                                              */
/*==============================================================*/
create unique index TAREA_PK on TAREA (
ID_CLASE,
ID_TAREA
);

/*==============================================================*/
/* Index: TIENE5_FK                                             */
/*==============================================================*/
create  index TIENE5_FK on TAREA (
ID_CLASE
);

/*==============================================================*/
/* Table: TIPO_ARCHIVO                                          */
/*==============================================================*/
create table TIPO_ARCHIVO (
   ID_TIPO_ARCHIVO      SERIAL               not null,
   EXTENCION            VARCHAR(30)          not null,
   constraint PK_TIPO_ARCHIVO primary key (ID_TIPO_ARCHIVO)
);

/*==============================================================*/
/* Index: TIPO_ARCHIVO_PK                                       */
/*==============================================================*/
create unique index TIPO_ARCHIVO_PK on TIPO_ARCHIVO (
ID_TIPO_ARCHIVO
);

/*==============================================================*/
/* Table: UI                                                    */
/*==============================================================*/
create table UI (
   ID_UI                SERIAL               not null,
   NOMBRE_UI            VARCHAR(50)          not null,
   ACTIVO               BOOL                 not null,
   constraint PK_UI primary key (ID_UI)
);

/*==============================================================*/
/* Index: UI_PK                                                 */
/*==============================================================*/
create unique index UI_PK on UI (
ID_UI
);

/*==============================================================*/
/* Table: USERN_ROL                                             */
/*==============================================================*/
create table USERN_ROL (
   CI                   INT4                 not null,
   ID_ROL               INT4                 not null,
   FECHA_ACTIVACION     DATE                 not null,
   constraint PK_USERN_ROL primary key (CI, ID_ROL, FECHA_ACTIVACION)
);

/*==============================================================*/
/* Index: USERN_ROL_PK                                          */
/*==============================================================*/
create unique index USERN_ROL_PK on USERN_ROL (
CI,
ID_ROL,
FECHA_ACTIVACION
);

/*==============================================================*/
/* Index: ESTA_FK                                               */
/*==============================================================*/
create  index ESTA_FK on USERN_ROL (
ID_ROL
);

/*==============================================================*/
/* Index: TIENES_FK                                             */
/*==============================================================*/
create  index TIENES_FK on USERN_ROL (
CI
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO (
   CI                   SERIAL               not null,
   NOMBRE               CHAR(50)             not null,
   APELLIDO             CHAR(50)             not null,
   CORREO               VARCHAR(50)          not null,
   CONTRASENA           VARCHAR(50)          not null,
   FECHANACIMIENTO      DATE                 not null,
   constraint PK_USUARIO primary key (CI)
);

ALTER TABLE USUARIO
ADD CONSTRAINT CHK_FECHA_NACIMIENTO
CHECK (FECHANACIMIENTO < CURRENT_DATE);

/*==============================================================*/
/* Index: USUARIO_PK                                            */
/*==============================================================*/
create unique index USUARIO_PK on USUARIO (
CI
);

alter table ALBUM
   add constraint FK_ALBUM_ESTA_UN_TAREA foreign key (ID_CLASE, ID_TAREA)
      references TAREA (ID_CLASE, ID_TAREA)
      on delete restrict on update restrict;

alter table ALBUM
   add constraint FK_ALBUM_TIENE_TIPO_ARC foreign key (ID_TIPO_ARCHIVO)
      references TIPO_ARCHIVO (ID_TIPO_ARCHIVO)
      on delete restrict on update restrict;

alter table CURSO
   add constraint FK_CURSO_DICTA_DOCENTE foreign key (CI)
      references DOCENTE (CI)
      on delete restrict on update restrict;

alter table DOCENTE
   add constraint FK_DOCENTE_ES2_USUARIO foreign key (CI)
      references USUARIO (CI)
      on delete restrict on update restrict;

alter table ENTREGA
   add constraint FK_ENTREGA_ENTREGA_ESTUDIAN foreign key (CI)
      references ESTUDIANTE (CI)
      on delete restrict on update restrict;

alter table ENTREGATAREA
   add constraint FK_ENTREGAT_ESTARA_EN_TAREA foreign key (TAR_ID_CLASE, ID_TAREA)
      references TAREA (ID_CLASE, ID_TAREA)
      on delete restrict on update restrict;

alter table ENTREGATAREA
   add constraint FK_ENTREGAT_SERA_ENTR_ENTREGA foreign key (CI, ID_ENTREGA)
      references ENTREGA (CI, ID_ENTREGA)
      on delete restrict on update restrict;

alter table ESTUDIANTE
   add constraint FK_ESTUDIAN_ES__USUARIO foreign key (CI)
      references USUARIO (CI)
      on delete restrict on update restrict;

alter table FUNCIO_UI
   add constraint FK_FUNCIO_U_ESTA2_UI foreign key (ID_UI)
      references UI (ID_UI)
      on delete restrict on update restrict;

alter table FUNCIO_UI
   add constraint FK_FUNCIO_U_TIENE2_FUNCION foreign key (ID_FUNCION)
      references FUNCION (ID_FUNCION)
      on delete restrict on update restrict;

alter table INSCRITO
   add constraint FK_INSCRITO_ESTARA_CURSO foreign key (ID_CLASE)
      references CURSO (ID_CLASE)
      on delete restrict on update restrict;

alter table INSCRITO
   add constraint FK_INSCRITO_PERTENECE_CARRERA foreign key (ID_CARRERA)
      references CARRERA (ID_CARRERA)
      on delete restrict on update restrict;

alter table INSCRITO
   add constraint FK_INSCRITO_SE_INSCRI_ESTUDIAN foreign key (CI)
      references ESTUDIANTE (CI)
      on delete restrict on update restrict;

alter table PUBLICACION
   add constraint FK_PUBLICAC_ES_PUBLIC_TAREA foreign key (ID_CLASE, ID_TAREA)
      references TAREA (ID_CLASE, ID_TAREA)
      on delete restrict on update restrict;

alter table ROL_FUNCION
   add constraint FK_ROL_FUNC_ES_ROL foreign key (ID_ROL)
      references ROL (ID_ROL)
      on delete restrict on update restrict;

alter table ROL_FUNCION
   add constraint FK_ROL_FUNC_TIENE1_FUNCION foreign key (ID_FUNCION)
      references FUNCION (ID_FUNCION)
      on delete restrict on update restrict;

alter table SESION
   add constraint FK_SESION_A_USUARIO foreign key (CI)
      references USUARIO (CI)
      on delete restrict on update restrict;

alter table TAREA
   add constraint FK_TAREA_TIENE5_CURSO foreign key (ID_CLASE)
      references CURSO (ID_CLASE)
      on delete restrict on update restrict;

alter table USERN_ROL
   add constraint FK_USERN_RO_ESTA_ROL foreign key (ID_ROL)
      references ROL (ID_ROL)
      on delete restrict on update restrict;

alter table USERN_ROL
   add constraint FK_USERN_RO_TIENES_USUARIO foreign key (CI)
      references USUARIO (CI)
      on delete restrict on update restrict;
	  
	 
	 
/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     7/4/2024 22:30:22                            */
/*==============================================================*/


/*==============================================================*/
/* Table: LOGUSER                                               */
/*==============================================================*/
create table LOGUSER (
   ID_LOG               SERIAL               not null,
   IDENTIFICACION       VARCHAR(50)          not null,
   FECHAEVENTO          DATE                 not null,
   HORAEVENTO           TIME                 not null,
   DATO_NUEVO           VARCHAR(500)         not null,
   DATO_VIEJO_          VARCHAR(500)         not null,
   TABLA                VARCHAR(50)          not null,
   EVENTO               VARCHAR(50)          not null,
   constraint PK_LOGUSER primary key (ID_LOG)
);

/*==============================================================*/
/* Index: LOGUSER_PK                                            */
/*==============================================================*/
create unique index LOGUSER_PK on LOGUSER (
ID_LOG
);


-- Agregar una nueva columna NUEVO_NOMBRE_ALBUM de tipo BYTEA
ALTER TABLE ALBUM
ADD COLUMN NUEVO_NOMBRE_ALBUM BYTEA;

-- Actualizar la nueva columna con el contenido binario de la columna original
UPDATE ALBUM
SET NUEVO_NOMBRE_ALBUM = CAST(NOMBRE_ALBUM AS BYTEA);

-- Eliminar la columna original NOMBRE_ALBUM
ALTER TABLE ALBUM
DROP COLUMN NOMBRE_ALBUM;

-- Renombrar la nueva columna a NOMBRE_ALBUM (opcional)
ALTER TABLE ALBUM
RENAME COLUMN NUEVO_NOMBRE_ALBUM TO NOMBRE_ALBUM;


