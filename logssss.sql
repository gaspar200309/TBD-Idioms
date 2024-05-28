/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     24/4/2024 14:28:55                           */
/*==============================================================*/


drop index ALBUM_PK;

drop table ALBUM;

drop index CARRERA_PK;

drop table CARRERA;

drop index DICTA_FK;

drop index CURSO_PK;

drop table CURSO;

drop index DOCENTE_PK;

drop table DOCENTE;

drop index SE_ENTREGA_FK;

drop index ENTREGA_FK;

drop index ENTREGATAREA_PK;

drop table ENTREGATAREA;

drop index ESTUDIANTE_PK;

drop table ESTUDIANTE;

drop index FUNCION_PK;

drop table FUNCION;

drop index ESTA2_FK;

drop index TIENE2_FK;

drop index FUNCIO_UI_PK;

drop table FUNCIO_UI;

drop index ESTARA_FK;

drop index SE_INSCRIBIO_FK;

drop index ESTA3_FK;

drop index INSCRITO_PK;

drop table INSCRITO;

drop index TIENE5_FK;

drop index PUBLICACION_PK;

drop table PUBLICACION;

drop index ROL_PK;

drop table ROL;

drop index TIENE1_FK;

drop index ES_FK;

drop index ROL_FUNCION_PK;

drop table ROL_FUNCION;

drop index A_FK;

drop index SESION_PK;

drop table SESION;

drop index TAREA_PK;

drop table TAREA;

drop index UI_PK;

drop table UI;

drop index TIENES_FK;

drop index ESTA_FK;

drop index USERN_ROL_PK;

drop table USERN_ROL;

drop index USUARIO_PK;

drop table USUARIO;

/*==============================================================*/
/* Table: ALBUM                                                 */
/*==============================================================*/
create table ALBUM (
   ID_TRABAJO           INT4                 not null,
   ID_CLASE             INT4                 not null,
   CI                   INT4                 not null,
   FECHA_PUBLICACION    DATE                 not null,
   ID_ALBUM             SERIAL               not null,
   NOMBRE_ALBUM         CHAR(500)            not null,
   constraint PK_ALBUM primary key (ID_TRABAJO, ID_CLASE, CI, FECHA_PUBLICACION)
);

/*==============================================================*/
/* Index: ALBUM_PK                                              */
/*==============================================================*/
create unique index ALBUM_PK on ALBUM (
ID_TRABAJO,
ID_CLASE,
CI,
FECHA_PUBLICACION
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
/* Table: ENTREGATAREA                                          */
/*==============================================================*/
create table ENTREGATAREA (
   ID_TRABAJO           INT4                 not null,
   ID_CLASE             INT4                 not null,
   CI                   INT4                 not null,
   FECHA_PUBLICACION    DATE                 not null,
   constraint PK_ENTREGATAREA primary key (ID_TRABAJO, ID_CLASE, CI, FECHA_PUBLICACION)
);

/*==============================================================*/
/* Index: ENTREGATAREA_PK                                       */
/*==============================================================*/
create unique index ENTREGATAREA_PK on ENTREGATAREA (
ID_TRABAJO,
ID_CLASE,
CI,
FECHA_PUBLICACION
);

/*==============================================================*/
/* Index: ENTREGA_FK                                            */
/*==============================================================*/
create  index ENTREGA_FK on ENTREGATAREA (
ID_CLASE,
CI
);

/*==============================================================*/
/* Index: SE_ENTREGA_FK                                         */
/*==============================================================*/
create  index SE_ENTREGA_FK on ENTREGATAREA (
ID_TRABAJO
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
   constraint PK_INSCRITO primary key (ID_CLASE, CI)
);

/*==============================================================*/
/* Index: INSCRITO_PK                                           */
/*==============================================================*/
create unique index INSCRITO_PK on INSCRITO (
ID_CLASE,
CI
);

/*==============================================================*/
/* Index: ESTA3_FK                                              */
/*==============================================================*/
create  index ESTA3_FK on INSCRITO (
ID_CARRERA
);

/*==============================================================*/
/* Index: SE_INSCRIBIO_FK                                       */
/*==============================================================*/
create  index SE_INSCRIBIO_FK on INSCRITO (
CI
);

/*==============================================================*/
/* Index: ESTARA_FK                                             */
/*==============================================================*/
create  index ESTARA_FK on INSCRITO (
ID_CLASE
);

/*==============================================================*/
/* Table: PUBLICACION                                           */
/*==============================================================*/
create table PUBLICACION (
   ID_TRABAJO           SERIAL               not null,
   ID_CLASE             INT4                 null,
   TIRULODETRABAJO      CHAR(50)             not null,
   DESCRIPCIONTRABAJO_  VARCHAR(250)         not null,
   FECHA_PUBLICACION    DATE                 null,
   constraint PK_PUBLICACION primary key (ID_TRABAJO)
);

/*==============================================================*/
/* Index: PUBLICACION_PK                                        */
/*==============================================================*/
create unique index PUBLICACION_PK on PUBLICACION (
ID_TRABAJO
);

/*==============================================================*/
/* Index: TIENE5_FK                                             */
/*==============================================================*/
create  index TIENE5_FK on PUBLICACION (
ID_CLASE
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
   ID_TRABAJO           INT4                 not null,
   TITULO               VARCHAR(50)          not null,
   FECHA_LIMITE_        DATE                 not null,
   NOTA                 INT4                 not null,
   constraint PK_TAREA primary key (ID_TRABAJO)
);

/*==============================================================*/
/* Index: TAREA_PK                                              */
/*==============================================================*/
create unique index TAREA_PK on TAREA (
ID_TRABAJO
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

/*==============================================================*/
/* Index: USUARIO_PK                                            */
/*==============================================================*/
create unique index USUARIO_PK on USUARIO (
CI
);

alter table ALBUM
   add constraint FK_ALBUM_ESTA_UN_ENTREGAT foreign key (ID_TRABAJO, ID_CLASE, CI, FECHA_PUBLICACION)
      references ENTREGATAREA (ID_TRABAJO, ID_CLASE, CI, FECHA_PUBLICACION)
      on delete restrict on update restrict;

alter table CURSO
   add constraint FK_CURSO_DICTA_DOCENTE foreign key (CI)
      references DOCENTE (CI)
      on delete restrict on update restrict;

alter table DOCENTE
   add constraint FK_DOCENTE_ES2_USUARIO foreign key (CI)
      references USUARIO (CI)
      on delete restrict on update restrict;

alter table ENTREGATAREA
   add constraint FK_ENTREGAT_ENTREGA_INSCRITO foreign key (ID_CLASE, CI)
      references INSCRITO (ID_CLASE, CI)
      on delete restrict on update restrict;

alter table ENTREGATAREA
   add constraint FK_ENTREGAT_SE_ENTREG_TAREA foreign key (ID_TRABAJO)
      references TAREA (ID_TRABAJO)
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
   add constraint FK_INSCRITO_ESTA3_CARRERA foreign key (ID_CARRERA)
      references CARRERA (ID_CARRERA)
      on delete restrict on update restrict;

alter table INSCRITO
   add constraint FK_INSCRITO_ESTARA_CURSO foreign key (ID_CLASE)
      references CURSO (ID_CLASE)
      on delete restrict on update restrict;

alter table INSCRITO
   add constraint FK_INSCRITO_SE_INSCRI_ESTUDIAN foreign key (CI)
      references ESTUDIANTE (CI)
      on delete restrict on update restrict;

alter table PUBLICACION
   add constraint FK_PUBLICAC_TIENE5_CURSO foreign key (ID_CLASE)
      references CURSO (ID_CLASE)
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
   add constraint FK_TAREA_ESTA1_PUBLICAC foreign key (ID_TRABAJO)
      references PUBLICACION (ID_TRABAJO)
      on delete restrict on update restrict;

alter table USERN_ROL
   add constraint FK_USERN_RO_ESTA_ROL foreign key (ID_ROL)
      references ROL (ID_ROL)
      on delete restrict on update restrict;

alter table USERN_ROL
   add constraint FK_USERN_RO_TIENES_USUARIO foreign key (CI)
      references USUARIO (CI)
      on delete restrict on update restrict;

