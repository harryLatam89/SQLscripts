drop index LLENAN_FK on CARRITO;

drop table if exists CARRITO;

drop index CARRITODETALLE_FK on CARRITODETALLE;

drop table if exists CARRITODETALLE;

drop table if exists CATEGORIA;

drop table if exists METODOPAGO;

drop index ROLESOPCIONESMENU_FK on OPCIONMENU;

drop table if exists OPCIONMENU;

drop index UTILIZAN_FK on PAGO;

drop table if exists PAGO;

drop index GENERA_FK on PEDIDO;

drop table if exists PEDIDO;

drop index PEDIDODETALLE_FK on PEDIDODETALLE;

drop table if exists PEDIDODETALLE;

drop table if exists PRODUCTO;

drop table if exists ROL;

drop index CORRESPONDE_FK on USUARIO;

drop table if exists USUARIO;

create table CARRITO
(
   IDCARRITO                      int                            not null,
   IDUSUARIO                      int                            not null,
   CREACIONCAR                    datetime                       not null,
   ACTUALIZACIONCAR               datetime                       not null,
   primary key (IDCARRITO)
)
type = InnoDB;

create index LLENAN_FK on CARRITO
(
   IDUSUARIO
);

create table CARRITODETALLE
(
   IDCARRITO                      int                            not null,
   IDPRODUCTO                     int                            not null,
   CANTIDADCARRITO                int                            not null,
   primary key (IDCARRITO, IDPRODUCTO)
)
type = InnoDB;

/*==============================================================*/
/* Index: "CARRITODETALLEPRODUCTO_FK"                                            */
/*==============================================================*/
create index CARRITODETALLEPRODUCTO_FK
(
   IDPRODUCTO
);

create index CARRITODETALLE_FK on CARRITODETALLE
(
   IDCARRITO
);

create table CATEGORIA
(
   IDCATEGORIA                    int                            not null,
   IDUSUARIO                      int                            not null,
   NOMBRECATEGORIA                char(55)                       not null,
   DESCRIPCIONCAT                 char(256)                      not null,
   ACTUALIZACIONCAT               datetime                       not null,
   CREACIONCAT                    datetime                       not null,
   primary key (IDCATEGORIA)
)
type = InnoDB;

/*==============================================================*/
/* Index: "GESTIONA_FK"                                            */
/*==============================================================*/
create index GESTIONA_FK
(
   IDUSUARIO
);

create table METODOPAGO
(
   IDMETODOPAGO                   int                            not null,
   NOMBREMETODO                   char(55)                       not null,
   DESCRIPCIONMETODO              char(256)                      not null,
   primary key (IDMETODOPAGO)
)
type = InnoDB;

create table OPCIONMENU
(
   IDOPCION                       char(3)                        not null,
   NOMBREROL                      char(15)                       not null,
   DESCRIPOPCION                  char(30)                       not null,
   primary key (IDOPCION)
)
type = InnoDB;

create index ROLESOPCIONESMENU_FK on OPCIONMENU
(
   NOMBREROL
);

create table PAGO
(
   IDPAGO                         char(64)                       not null,
   IDMETODOPAGO                   int                            not null,
   IDPEDIDO                       char(64),
   MONTO                          decimal(12,2)                  not null,
   FECHAPAGO                      datetime                       not null,
   primary key (IDPAGO)
)
type = InnoDB;

/*==============================================================*/
/* Index: "PAGOPEDIDO_FK"                                            */
/*==============================================================*/
create index PAGOPEDIDO_FK
(
   IDPEDIDO
);

create index UTILIZAN_FK on PAGO
(
   IDMETODOPAGO
);

create table PEDIDO
(
   IDPEDIDO                       char(64)                       not null,
   IDUSUARIO                      int                            not null,
   IDPAGO                         char(64)                       not null,
   FECHAPEDIDO                    datetime                       not null,
   ESTADOPEDIDO                   char(10)                       not null,
   TIPOENGREGA                    char(25)                       not null,
   FECHAENTREGA                   datetime                       not null,
   COSTOENVIO                     decimal(12,2)                  not null,
   primary key (IDPEDIDO)
)
type = InnoDB;

/*==============================================================*/
/* Index: "INCLUYE_FK"                                            */
/*==============================================================*/
create index INCLUYE_FK
(
   IDPAGO
);

create index GENERA_FK on PEDIDO
(
   IDUSUARIO
);

create table PEDIDODETALLE
(
   IDPEDIDO                       char(64)                       not null,
   IDPRODUCTO                     int                            not null,
   CANTIDADPEDIDO                 int                            not null,
   primary key (IDPEDIDO, IDPRODUCTO)
)
type = InnoDB;

/*==============================================================*/
/* Index: "PEDIDODETALLEPRODUCTO_FK"                                            */
/*==============================================================*/
create index PEDIDODETALLEPRODUCTO_FK
(
   IDPRODUCTO
);

create index PEDIDODETALLE_FK on PEDIDODETALLE
(
   IDPEDIDO
);

create table PRODUCTO
(
   IDPRODUCTO                     int                            not null,
   IDUSUARIO                      int                            not null,
   IDCATEGORIA                    int                            not null,
   NOMBREPRODUCTO                 char(55)                       not null,
   DESCRIPCCIONPROD               char(256)                      not null,
   PRECIOVENTAPROD                decimal(12,2)                  not null,
   PROMOCIONPROD                  decimal(12,2)                  not null,
   PRECIOCOSTOPROD                decimal(12,2)                  not null,
   CANTIDADPROD                   int                            not null,
   IMAGENURLPROD                  longblob                       not null,
   CREACIONPROD                   datetime                       not null,
   ACTUALIZACION                  datetime                       not null,
   primary key (IDPRODUCTO)
)
type = InnoDB;

/*==============================================================*/
/* Index: "REGISTRAN_FK"                                            */
/*==============================================================*/
create index REGISTRAN_FK
(
   IDUSUARIO
);
/*==============================================================*/
/* Index: "PERTENCEA_FK"                                            */
/*==============================================================*/
create index PERTENCEA_FK
(
   IDCATEGORIA
);

create table ROL
(
   NOMBREROL                      char(15)                       not null,
   DESCRIPROL                     char(50)                       not null,
   primary key (NOMBREROL)
)
type = InnoDB;

create table USUARIO
(
   IDUSUARIO                      int                            not null,
   NOMBREROL                      char(15)                       not null,
   NOMBREUSUARIO                  char(30)                       not null,
   APELLIDOUSUARIO                char(30)                       not null,
   CORREO                         char(30)                       not null,
   CONTRASENHA                    char(30)                       not null,
   CREACIONUSUARIO                datetime                       not null,
   ACTUALIZACIONUSUARIO           datetime                       not null,
   ESTADOUSUARIO                  char(10)                       not null,
   DIRECCIONUSUARIO               char(256)                      not null,
   TELEFONO                       numeric(8,0)                   not null,
   primary key (IDUSUARIO)
)
type = InnoDB;

create index CORRESPONDE_FK on USUARIO
(
   NOMBREROL
);

alter table CARRITO add constraint FK_LLENAN foreign key (IDUSUARIO)
      references USUARIO (IDUSUARIO) on delete restrict on update restrict;

alter table CARRITODETALLE add constraint FK_CARRITODETALLE foreign key (IDCARRITO)
      references CARRITO (IDCARRITO) on delete restrict on update restrict;

alter table CARRITODETALLE add constraint FK_CARRITODETALLEPRODUCTO foreign key (IDPRODUCTO)
      references PRODUCTO (IDPRODUCTO) on delete restrict on update restrict;

alter table CATEGORIA add constraint FK_GESTIONA foreign key (IDUSUARIO)
      references USUARIO (IDUSUARIO) on delete restrict on update restrict;

alter table OPCIONMENU add constraint FK_ROLESOPCIONESMENU foreign key (NOMBREROL)
      references ROL (NOMBREROL) on delete restrict on update restrict;

alter table PAGO add constraint FK_PAGOPEDIDO foreign key (IDPEDIDO)
      references PEDIDO (IDPEDIDO) on delete restrict on update restrict;

alter table PAGO add constraint FK_UTILIZAN foreign key (IDMETODOPAGO)
      references METODOPAGO (IDMETODOPAGO) on delete restrict on update restrict;

alter table PEDIDO add constraint FK_GENERA foreign key (IDUSUARIO)
      references USUARIO (IDUSUARIO) on delete restrict on update restrict;

alter table PEDIDO add constraint FK_INCLUYE foreign key (IDPAGO)
      references PAGO (IDPAGO) on delete restrict on update restrict;

alter table PEDIDODETALLE add constraint FK_PEDIDODETALLE foreign key (IDPEDIDO)
      references PEDIDO (IDPEDIDO) on delete restrict on update restrict;

alter table PEDIDODETALLE add constraint FK_PEDIDODETALLEPRODUCTO foreign key (IDPRODUCTO)
      references PRODUCTO (IDPRODUCTO) on delete restrict on update restrict;

alter table PRODUCTO add constraint FK_PERTENCEA foreign key (IDCATEGORIA)
      references CATEGORIA (IDCATEGORIA) on delete restrict on update restrict;

alter table PRODUCTO add constraint FK_REGISTRAN foreign key (IDUSUARIO)
      references USUARIO (IDUSUARIO) on delete restrict on update restrict;

alter table USUARIO add constraint FK_CORRESPONDE foreign key (NOMBREROL)
      references ROL (NOMBREROL) on delete restrict on update restrict;

