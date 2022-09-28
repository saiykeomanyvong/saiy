CREATE DATABASE Store
Use Store;

CREATE SCHEMA production; 
go
CREATE SCHEMA sales;
go

CREATE TABLE production.categories (
category_id int IDENTITY (1,1) PRIMARY KEY,
cetegory_name VARCHAR (255) NOT NULL
);
CREATE TABLE production.brands (
category_id int IDENTITY (1,1) PRIMARY KEY,
cetegory_name VARCHAR (255) NOT NULL
);
CREATE TABLE production.productions (
product_id INT IDENTITY (1,1) PRIMARY KEY,
product_name VARCHAR (255) NOT NULL,
brand_id INT NOT NULL,
category_id INT NOT NULL,
model_yesr smallint not null,
list_price DECIMAL (10, 2) NOT NULL,
);
CREATE TABLE sales.customers(
cusotomer_id int identity (1,1) primary key,
first_name varchar (255) not null,
last_name varchar (255) not null,
phone varchar (50), 
email varchar (255) not null,
street varchar (255), 
city varchar (50),
state varchar (25), 
zip_code varchar (5), 
);


create table sales.stores(
store_id int identity (1,1) primary key,
store_name varchar(255) not null,
phone varchar(25),
email varchar(255),
street varchar(255),
city varchar(50),
state varchar(10),
zip_code varchar(5)
);

create table sales.staffs(
staff_id int identity (1,1) primary key,
frist_name varchar(500) not null,
last_name varchar(50) not null,
email varchar(255) not null unique,
phone varchar(25),
active tinyint not null,
store_id int not null,
manager_id int,
foreign key (store_id) references sales.stores(store_id) on delete cascade on update cascade,
foreign key (manager_id) references sales.staffs(staff_id) on delete no action on update no action
);

create table sales.orders(
order_id int identity (1,1) primary key,
customer_id int,
order_data date not null,
required_data date not null,
shipped_date date,
store_id int not null,
staff_id int not null,
foreign key (customer_id) references sales.customers(cusotomer_id) on delete cascade on update cascade,
foreign key (store_id) references sales.stores(store_id) on delete cascade on update cascade,
foreign key (staff_id) references sales.staffs(staff_id) on delete no action on update no action,
);

create table sales.order_items(
order_id int,
item_id int,
product_id int not null,
quantity int not null,
list_price decimal(10,2)not null,
discount decimal(4,2) not null default 0,
primary key (order_id, item_id),
foreign key (order_id) references sales.stores(store_id) on delete cascade on update cascade,
foreign key (product_id) references production.productions(product_id) on delete cascade on update cascade,
);

create table production.stocks(
store_id int,
product_id int,
quantity int,
primary key (store_id, product_id),
foreign key (store_id) references sales.orders(order_id) on delete cascade on update cascade,
foreign key (product_id) references production.productions(product_id) on delete cascade on update cascade,
);






