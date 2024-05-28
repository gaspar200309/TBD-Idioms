/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     7/4/2024 13:32:10                            */
/*==============================================================*/

/*==============================================================*/
/* Table: CARRERA                                               */
/*==============================================================*/
CREATE TABLE CARRERA (
   ID_CARRERA           SERIAL               NOT NULL,
   NOMBRECARRERA        CHAR(50)             NOT NULL CHECK (NOMBRECARRERA ~ '^[A-Za-z]+$'),
   CONSTRAINT PK_CARRERA PRIMARY KEY (ID_CARRERA)
);

/*==============================================================*/
/* Index: CARRERA_PK                                            */
/*==============================================================*/
CREATE UNIQUE INDEX CARRERA_PK ON CARRERA (
ID_CARRERA
);

/*==============================================================*/
/* Table: CLASE                                                 */
/*==============================================================*/
CREATE TABLE CLASE (
   ID_CLASE             DATE                 NOT NULL,
   CI                   INT4                 NULL,
   NOMBRE_CLASE         CHAR(50)             NOT NULL,
   CONSTRAINT PK_CLASE PRIMARY KEY (ID_CLASE)
);

/*==============================================================*/
/* Index: CLASE_PK                                              */
/*==============================================================*/
CREATE UNIQUE INDEX CLASE_PK ON CLASE (
ID_CLASE
);

/*==============================================================*/
/* Index: DICTA_FK                                              */
/*==============================================================*/
CREATE INDEX DICTA_FK ON CLASE (
CI
);

/*==============================================================*/
/* Table: DOCENTE                                               */
/*==============================================================*/
CREATE TABLE DOCENTE (
   CI                   INT4                 NOT NULL,
   ASIGNATURA           CHAR(50)             NOT NULL,
   CONSTRAINT PK_DOCENTE PRIMARY KEY (CI)
);

/*==============================================================*/
/* Index: DOCENTE_PK                                            */
/*==============================================================*/
CREATE UNIQUE INDEX DOCENTE_PK ON DOCENTE (
CI
);

/*==============================================================*/
/* Table: ENTREGATAREA                                          */
/*==============================================================*/
CREATE TABLE ENTREGATAREA (
   ID_CLASE             DATE                 NOT NULL,
   CI                   INT4                 NOT NULL,
   FECHA_INSCRIPCION_   DATE                 NOT NULL,
   ID_ENTREGA           SERIAL               NOT NULL,
   ARCHIVO              CHAR(100)            NOT NULL,
   NOTA                 INT4                 NOT NULL CHECK (NOTA >= 0 AND NOTA <= 100),
   CONSTRAINT PK_ENTREGATAREA PRIMARY KEY (ID_CLASE, CI, FECHA_INSCRIPCION_, ID_ENTREGA)
);

/*==============================================================*/
/* Index: ENTREGATAREA_PK                                       */
/*==============================================================*/
CREATE UNIQUE INDEX ENTREGATAREA_PK ON ENTREGATAREA (
ID_CLASE,
CI,
FECHA_INSCRIPCION_,
ID_ENTREGA
);

/*==============================================================*/
/* Index: RELATIONSHIP_10_FK                                    */
/*==============================================================*/
CREATE INDEX RELATIONSHIP_10_FK ON ENTREGATAREA (
ID_CLASE,
CI,
FECHA_INSCRIPCION_
);

/*==============================================================*/
/* Table: ESTUDIANTE                                            */
/*==============================================================*/
CREATE TABLE ESTUDIANTE (
   CI                   INT4                 NOT NULL,
   SEMESTRE             CHAR(50)             NOT NULL,
   CODIGOSIS            CHAR(10)             NOT NULL CHECK (CODIGOSIS ~ '^[0-9]+$'),
   CONSTRAINT PK_ESTUDIANTE PRIMARY KEY (CI)
);

/*==============================================================*/
/* Index: ESTUDIANTE_PK                                         */
/*==============================================================*/
CREATE UNIQUE INDEX ESTUDIANTE_PK ON ESTUDIANTE (
CI
);

/*==============================================================*/
/* Table: FUNCION                                               */
/*==============================================================*/
CREATE TABLE FUNCION (
   ID_FUNCION           SERIAL               NOT NULL,
   NOMBRE_FUNCION       VARCHAR(50)          NOT NULL,
   ACTIVOF              BOOL                 NOT NULL,
   CONSTRAINT PK_FUNCION PRIMARY KEY (ID_FUNCION)
);

/*==============================================================*/
/* Index: FUNCION_PK                                            */
/*==============================================================*/
CREATE UNIQUE INDEX FUNCION_PK ON FUNCION (
ID_FUNCION
);

/*==============================================================*/
/* Table: FUNCIO_UI                                             */
/*==============================================================*/
CREATE TABLE FUNCIO_UI (
   ID_UI                INT4                 NOT NULL,
   ID_FUNCION           INT4                 NOT NULL,
   FECHA_INICIO         DATE                 NOT NULL CHECK (FECHA_INICIO > CURRENT_DATE),
   CONSTRAINT PK_FUNCIO_UI PRIMARY KEY (ID_UI, ID_FUNCION, FECHA_INICIO)
);

/*==============================================================*/
/* Index: FUNCIO_UI_PK                                          */
/*==============================================================*/
CREATE UNIQUE INDEX FUNCIO_UI_PK ON FUNCIO_UI (
ID_UI,
ID_FUNCION,
FECHA_INICIO
);

/*==============================================================*/
/* Index: TIENE2_FK                                             */
/*==============================================================*/
CREATE INDEX TIENE2_FK ON FUNCIO_UI (
ID_FUNCION
);

/*==============================================================*/
/* Index: ESTA2_FK                                              */
/*==============================================================*/
CREATE INDEX ESTA2_FK ON FUNCIO_UI (
ID_UI
);

/*==============================================================*/
/* Table: INSCRITO                                              */
/*==============================================================*/
CREATE TABLE INSCRITO (
   ID_CLASE             DATE                 NOT NULL,
   CI                   INT4                 NOT NULL,
   FECHA_INSCRIPCION_   DATE                 NOT NULL CHECK (FECHA_INSCRIPCION_ > CURRENT_DATE - INTERVAL '1 year' AND FECHA_INSCRIPCION_ <= CURRENT_DATE),
   ID_CARRERA           INT4                 NULL,
   CONSTRAINT PK_INSCRITO PRIMARY KEY (ID_CLASE, CI, FECHA_INSCRIPCION_)
);

/*==============================================================*/
/* Index: INSCRITO_PK                                           */
/*==============================================================*/
CREATE UNIQUE INDEX INSCRITO_PK ON INSCRITO (
ID_CLASE,
CI,
FECHA_INSCRIPCION_
);

/*==============================================================*/
/* Index: ESTA3_FK                                              */
/*==============================================================*/
CREATE INDEX ESTA3_FK ON INSCRITO (
ID_CARRERA
);

/*==============================================================*/
/* Index: SE_INSCRIBIO_FK                                       */
/*==============================================================*/
CREATE INDEX SE_INSCRIBIO_FK ON INSCRITO (
CI
);

/*==============================================================*/
/* Index: ESTARA_FK                                             */
/*==============================================================*/
CREATE INDEX ESTARA_FK ON INSCRITO (
ID_CLASE
);

/*==============================================================*/
/* Table: PUBLICACION                                           */
/*==============================================================*/
CREATE TABLE PUBLICACION (
   CI                   INT4                 NOT NULL,
   ID_TRABAJO           INT4                 NOT NULL,
   FECHAPUBLICACION     DATE                 NOT NULL CHECK (FECHAPUBLICACION > CURRENT_DATE - INTERVAL '1 year' AND FECHAPUBLICACION <= CURRENT_DATE),
   ID_CLASE             DATE                 NULL,
   CONSTRAINT PK_PUBLICACION PRIMARY KEY (CI, ID_TRABAJO, FECHAPUBLICACION)
);

/*==============================================================*/
/* Index: PUBLICACION_PK                                        */
/*==============================================================*/
CREATE UNIQUE INDEX PUBLICACION_PK ON PUBLICACION (
CI,
ID_TRABAJO,
FECHAPUBLICACION
);

/*==============================================================*/
/* Index: TIENE5_FK                                             */
/*==============================================================*/
CREATE INDEX TIENE5_FK ON PUBLICACION (
ID_CLASE
);

/*==============================================================*/
/* Index: ESTA4_FK                                              */
/*==============================================================*/
CREATE INDEX ESTA4_FK ON PUBLICACION (
CI,
ID_TRABAJO
);

/*==============================================================*/
/* Table: ROL                                                   */
/*==============================================================*/
CREATE TABLE ROL (
   ID_ROL               SERIAL               NOT NULL,
   NOMBRE_ROL           VARCHAR(50)          NOT NULL,
   ACTIVEROL            BOOL                 NOT NULL,
   CONSTRAINT PK_ROL PRIMARY KEY (ID_ROL)
);

/*==============================================================*/
/* Index: ROL_PK                                                */
/*==============================================================*/
CREATE UNIQUE INDEX ROL_PK ON ROL (
ID_ROL
);

/*==============================================================*/
/* Table: ROL_FUNCION                                           */
/*==============================================================*/
CREATE TABLE ROL_FUNCION (
   ID_FUNCION           INT4                 NOT NULL,
   ID_ROL               INT4                 NOT NULL,
   FECHA_ACTROL         DATE                 NOT NULL,
   CONSTRAINT PK_ROL_FUNCION PRIMARY KEY (ID_FUNCION, ID_ROL, FECHA_ACTROL)
);

/*==============================================================*/
/* Index: ROL_FUNCION_PK                                        */
/*==============================================================*/
CREATE UNIQUE INDEX ROL_FUNCION_PK ON ROL_FUNCION (
ID_FUNCION,
ID_ROL,
FECHA_ACTROL
);

/*==============================================================*/
/* Index: ES_FK                                                 */
/*==============================================================*/
CREATE INDEX ES_FK ON ROL_FUNCION (
ID_ROL
);

/*==============================================================*/
/* Index: TIENE1_FK                                             */
/*==============================================================*/
CREATE INDEX TIENE1_FK ON ROL_FUNCION (
ID_FUNCION
);

/*==============================================================*/
/* Table: SESION                                                */
/*==============================================================*/
CREATE TABLE SESION (
   CI                   INT4                 NOT NULL,
   ID_SESION            SERIAL               NOT NULL,
   PID                  INT4                 NOT NULL,
   FECHA_SESION         DATE                 NOT NULL,
   CONSTRAINT PK_SESION PRIMARY KEY (CI, ID_SESION)
);

/*==============================================================*/
/* Index: SESION_PK                                             */
/*==============================================================*/
CREATE UNIQUE INDEX SESION_PK ON SESION (
CI,
ID_SESION
);

/*==============================================================*/
/* Index: A_FK                                                  */
/*==============================================================*/
CREATE INDEX A_FK ON SESION (
CI
);

/*==============================================================*/
/* Table: TRABAJODECLASE                                        */
/*==============================================================*/
CREATE TABLE TRABAJODECLASE (
   CI                   INT4                 NOT NULL,
   ID_TRABAJO           SERIAL               NOT NULL,
   TIRULODETRABAJO      CHAR(50)             NOT NULL,
   DESCRIPCIONTRABAJO_  VARCHAR(250)         NOT NULL,
   FECHAINI             DATE                 NOT NULL,
   FECHAFIN             DATE                 NOT NULL,
   CONSTRAINT PK_TRABAJODECLASE PRIMARY KEY (CI, ID_TRABAJO)
);

/*==============================================================*/
/* Index: TRABAJODECLASE_PK                                     */
/*==============================================================*/
CREATE UNIQUE INDEX TRABAJODECLASE_PK ON TRABAJODECLASE (
CI,
ID_TRABAJO
);

/*==============================================================*/
/* Index: ASIGNA_FK                                             */
/*==============================================================*/
CREATE INDEX ASIGNA_FK ON TRABAJODECLASE (
CI
);

/*==============================================================*/
/* Table: UI                                                    */
/*==============================================================*/
CREATE TABLE UI (
   ID_UI                SERIAL               NOT NULL,
   NOMBRE_UI            VARCHAR(50)          NOT NULL,
   ACTIVO               BOOL                 NOT NULL,
   CONSTRAINT PK_UI PRIMARY KEY (ID_UI)
);

/*==============================================================*/
/* Index: UI_PK                                                 */
/*==============================================================*/
CREATE UNIQUE INDEX UI_PK ON UI (
ID_UI
);

/*==============================================================*/
/* Table: USERN_ROL                                             */
/*==============================================================*/
CREATE TABLE USERN_ROL (
   CI                   INT4                 NOT NULL,
   ID_ROL               INT4                 NOT NULL,
   FECHA_ACTIVACION     DATE                 NOT NULL CHECK (FECHA_ACTIVACION <= CURRENT_DATE),
   CONSTRAINT PK_USERN_ROL PRIMARY KEY (CI, ID_ROL, FECHA_ACTIVACION)
);

/*==============================================================*/
/* Index: USERN_ROL_PK                                          */
/*==============================================================*/
CREATE UNIQUE INDEX USERN_ROL_PK ON USERN_ROL (
CI,
ID_ROL,
FECHA_ACTIVACION
);

/*==============================================================*/
/* Index: ESTA_FK                                               */
/*==============================================================*/
CREATE INDEX ESTA_FK ON USERN_ROL (
ID_ROL
);

/*==============================================================*/
/* Index: TIENES_FK                                             */
/*==============================================================*/
CREATE INDEX TIENES_FK ON USERN_ROL (
CI
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
CREATE TABLE USUARIO (
   CI                   SERIAL               NOT NULL,
   NOMBRE               CHAR(50)             NOT NULL,
   APELLIDO             CHAR(50)             NOT NULL,
   CORREO               VARCHAR(50)          NOT NULL,
   CONTRASENA           VARCHAR(50)          NOT NULL,
   FECHANACIMIENTO      DATE                 NOT NULL CHECK (FECHANACIMIENTO <= CURRENT_DATE - INTERVAL '100 years'),
   CONSTRAINT PK_USUARIO PRIMARY KEY (CI)
);

/*==============================================================*/
/* Index: USUARIO_PK                                            */
/*==============================================================*/
CREATE UNIQUE INDEX USUARIO_PK ON USUARIO (
CI
);

ALTER TABLE CLASE
   ADD CONSTRAINT FK_CLASE_DICTA_DOCENTE FOREIGN KEY (CI)
      REFERENCES DOCENTE (CI)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE DOCENTE
   ADD CONSTRAINT FK_DOCENTE_ES2_USUARIO FOREIGN KEY (CI)
      REFERENCES USUARIO (CI)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE ENTREGATAREA
   ADD CONSTRAINT FK_ENTREGAT_RELATIONS_INSCRITO FOREIGN KEY (ID_CLASE, CI, FECHA_INSCRIPCION_)
      REFERENCES INSCRITO (ID_CLASE, CI, FECHA_INSCRIPCION_)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE ESTUDIANTE
   ADD CONSTRAINT FK_ESTUDIAN_ES__USUARIO FOREIGN KEY (CI)
      REFERENCES USUARIO (CI)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE FUNCIO_UI
   ADD CONSTRAINT FK_FUNCIO_U_ESTA2_UI FOREIGN KEY (ID_UI)
      REFERENCES UI (ID_UI)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE FUNCIO_UI
   ADD CONSTRAINT FK_FUNCIO_U_TIENE2_FUNCION FOREIGN KEY (ID_FUNCION)
      REFERENCES FUNCION (ID_FUNCION)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE INSCRITO
   ADD CONSTRAINT FK_INSCRITO_ESTA3_CARRERA FOREIGN KEY (ID_CARRERA)
      REFERENCES CARRERA (ID_CARRERA)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE INSCRITO
   ADD CONSTRAINT FK_INSCRITO_ESTARA_CLASE FOREIGN KEY (ID_CLASE)
      REFERENCES CLASE (ID_CLASE)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE INSCRITO
   ADD CONSTRAINT FK_INSCRITO_SE_INSCRI_ESTUDIAN FOREIGN KEY (CI)
      REFERENCES ESTUDIANTE (CI)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE PUBLICACION
   ADD CONSTRAINT FK_PUBLICAC_ESTA4_TRABAJOD FOREIGN KEY (CI, ID_TRABAJO)
      REFERENCES TRABAJODECLASE (CI, ID_TRABAJO)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE PUBLICACION
   ADD CONSTRAINT FK_PUBLICAC_TIENE5_CLASE FOREIGN KEY (ID_CLASE)
      REFERENCES CLASE (ID_CLASE)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE ROL_FUNCION
   ADD CONSTRAINT FK_ROL_FUNC_ES_ROL FOREIGN KEY (ID_ROL)
      REFERENCES ROL (ID_ROL)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE ROL_FUNCION
   ADD CONSTRAINT FK_ROL_FUNC_TIENE1_FUNCION FOREIGN KEY (ID_FUNCION)
      REFERENCES FUNCION (ID_FUNCION)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE SESION
   ADD CONSTRAINT FK_SESION_A_USUARIO FOREIGN KEY (CI)
      REFERENCES USUARIO (CI)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE TRABAJODECLASE
   ADD CONSTRAINT FK_TRABAJOD_ASIGNA_DOCENTE FOREIGN KEY (CI)
      REFERENCES DOCENTE (CI)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE USERN_ROL
   ADD CONSTRAINT FK_USERN_RO_ESTA_ROL FOREIGN KEY (ID_ROL)
      REFERENCES ROL (ID_ROL)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE USERN_ROL
   ADD CONSTRAINT FK_USERN_RO_TIENES_USUARIO FOREIGN KEY (CI)
      REFERENCES USUARIO (CI)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

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

