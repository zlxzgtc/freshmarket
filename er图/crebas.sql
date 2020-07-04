/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2020/7/4 8:10:38                             */
/*==============================================================*/


drop table if exists address;

drop table if exists category;

drop table if exists coupon;

drop table if exists discount;

drop table if exists evaluate;

drop table if exists evaluate_image;

drop table if exists goods;

drop table if exists goods_discount;

drop table if exists menu;

drop table if exists order_details;

drop table if exists orders;

drop table if exists promotion;

drop table if exists purchase;

drop table if exists recommond;

drop table if exists system_user;

drop table if exists user;

/*==============================================================*/
/* Table: address                                               */
/*==============================================================*/
create table address
(
   address_id           int not null,
   user_id              int,
   province             varchar(20) not null,
   city                 varchar(20) not null,
   area                 varchar(20) not null,
   detail               varchar(50) not null,
   contacts_name        varchar(20) not null,
   contacts_phone       varchar(20) not null,
   primary key (address_id)
);

/*==============================================================*/
/* Table: category                                              */
/*==============================================================*/
create table category
(
   category_id          int not null,
   category_name        varchar(16) not null,
   category_describe    text,
   primary key (category_id)
);

/*==============================================================*/
/* Table: coupon                                                */
/*==============================================================*/
create table coupon
(
   coupon_id            int not null,
   coupon_content       varchar(20) not null,
   coupon_applicable_amount decimal(10,2) not null,
   coupon_deduction_amount decimal(10,2) not null,
   coupon_start_time    timestamp not null,
   coupon_end_time      timestamp not null,
   primary key (coupon_id)
);

/*==============================================================*/
/* Table: discount                                              */
/*==============================================================*/
create table discount
(
   discount_id          int not null,
   discount_content     varchar(20) not null,
   discount_goods_count int not null,
   discount_number      decimal(10,2) not null,
   discount_start_time  timestamp not null,
   discount_end_time    timestamp not null,
   primary key (discount_id)
);

/*==============================================================*/
/* Table: evaluate                                              */
/*==============================================================*/
create table evaluate
(
   evaluate_id          int not null,
   user_id              int,
   goods_id             int,
   evaluate_time        timestamp not null,
   evaluate_starts      decimal(5,2) not null,
   primary key (evaluate_id)
);

/*==============================================================*/
/* Table: evaluate_image                                        */
/*==============================================================*/
create table evaluate_image
(
   evaluate_id          int,
   evaluate_image       varchar(50)
);

/*==============================================================*/
/* Table: goods                                                 */
/*==============================================================*/
create table goods
(
   goods_id             int not null,
   category_id          int,
   goods_name           char(16) not null,
   goods_price          decimal(10,2) not null,
   goods_vip_price      decimal(10,2) not null,
   goods_count          int not null,
   goods_norms          varchar(16) not null,
   goods_describe       varchar(256),
   primary key (goods_id)
);

/*==============================================================*/
/* Table: goods_discount                                        */
/*==============================================================*/
create table goods_discount
(
   goods_id             int not null,
   discount_id          int not null,
   discount_start_time  timestamp not null,
   discount_end_time    timestamp not null,
   primary key (goods_id, discount_id)
);

/*==============================================================*/
/* Table: menu                                                  */
/*==============================================================*/
create table menu
(
   menu_id              int not null,
   menu_name            varchar(16) not null,
   menu_material        varchar(256) not null,
   menu_step            varchar(256) not null,
   menu_image           varchar(256),
   primary key (menu_id)
);

/*==============================================================*/
/* Table: order_details                                         */
/*==============================================================*/
create table order_details
(
   goods_id             int not null,
   order_id             int not null,
   order_count          int not null,
   order_price          decimal(10,2) not null,
   discount_number      decimal(10,2),
   order_state          varchar(10) not null,
   primary key (goods_id, order_id)
);

/*==============================================================*/
/* Table: orders                                                */
/*==============================================================*/
create table orders
(
   order_id             int not null,
   coupon_id            int,
   address_id           int,
   user_id              int,
   original_amount      decimal(10,2) not null,
   calculation_amount   decimal(10,2) not null,
   require_time         timestamp not null,
   order_state          varchar(10) not null,
   primary key (order_id)
);

/*==============================================================*/
/* Table: promotion                                             */
/*==============================================================*/
create table promotion
(
   promotion_id         int not null,
   goods_id             int,
   promotion_price      decimal(10,2) not null,
   promotion_count      int not null,
   promotion_start_time timestamp not null,
   promotion_end_time   timestamp not null,
   primary key (promotion_id)
);

/*==============================================================*/
/* Table: purchase                                              */
/*==============================================================*/
create table purchase
(
   purchase_id          int not null,
   system_user_id       int,
   goods_id             int,
   purchase_count       int not null,
   purchase_state       varchar(20) not null,
   primary key (purchase_id)
);

/*==============================================================*/
/* Table: recommond                                             */
/*==============================================================*/
create table recommond
(
   goods_id             int not null,
   menu_id              int not null,
   recommond_describe   varchar(256),
   primary key (goods_id, menu_id)
);

/*==============================================================*/
/* Table: system_user                                           */
/*==============================================================*/
create table system_user
(
   system_user_id       int not null,
   system_user_name     varchar(20) not null,
   user_password        varchar(50) not null,
   primary key (system_user_id)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   user_id              int not null,
   user_name            varchar(20) not null,
   user_gender          bool not null,
   user_password        varchar(50) not null,
   user_phone           varchar(20),
   user_email           varchar(20),
   user_city            varchar(20),
   register_time        timestamp not null,
   is_vip               bool not null,
   vip_end_time         timestamp not null,
   primary key (user_id)
);

alter table address add constraint FK_Relationship_2 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table evaluate add constraint FK_Relationship_10 foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table evaluate add constraint FK_Relationship_11 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table evaluate_image add constraint FK_Relationship_12 foreign key (evaluate_id)
      references evaluate (evaluate_id) on delete restrict on update restrict;

alter table goods add constraint FK_Relationship_1 foreign key (category_id)
      references category (category_id) on delete restrict on update restrict;

alter table goods_discount add constraint FK_goods_discount foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table goods_discount add constraint FK_goods_discount2 foreign key (discount_id)
      references discount (discount_id) on delete restrict on update restrict;

alter table order_details add constraint FK_order_details foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table order_details add constraint FK_order_details2 foreign key (order_id)
      references orders (order_id) on delete restrict on update restrict;

alter table orders add constraint FK_Relationship_13 foreign key (address_id)
      references address (address_id) on delete restrict on update restrict;

alter table orders add constraint FK_Relationship_5 foreign key (coupon_id)
      references coupon (coupon_id) on delete restrict on update restrict;

alter table orders add constraint FK_Relationship_8 foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;

alter table promotion add constraint FK_Relationship_3 foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table purchase add constraint FK_Relationship_6 foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table purchase add constraint FK_Relationship_7 foreign key (system_user_id)
      references system_user (system_user_id) on delete restrict on update restrict;

alter table recommond add constraint FK_recommond foreign key (goods_id)
      references goods (goods_id) on delete restrict on update restrict;

alter table recommond add constraint FK_recommond2 foreign key (menu_id)
      references menu (menu_id) on delete restrict on update restrict;

