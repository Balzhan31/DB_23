create database lecture2
    with owner parlam_user;

drop database lecture2;

create database lecture3
    connection limit 1
    is_template true;

show data_directory;

create tablespace lecture2_tablespace
    location '/Users/aibekkuralbayev/Desktop/lecture_2_data';


create database lecture2 tablespace lecture2_tablespace;

drop database lecture2;


create table users
(
    id       serial primary key,
    fullname varchar(200),
    username varchar(100)
);

select *
from users;

drop table users_copy;
create table users_copy
(
    like users including constraints,
    age integer
);


insert into users (fullname, username)
VALUES ('John Smith', 'john'),
       ('John Smith2', 'john2');

select *
from users;

create table users_child
(
    age   int,
    email varchar(100)
) inherits (users);

select *
from users;

select *
from users_child;

insert into users (fullname, username)
VALUES ('Bob', 'bob');

insert into users_child (fullname, username, age, email)
VALUES ('Bob2', 'bob2', 10, 'bob@gmai.com');



create table products
(
    id    serial primary key,
    name  varchar(200),
    price float default 9.99
);


insert into products (name, price)
VALUES ('Coke', 15);
select *
from products;

insert into products (name)
values ('Pepsi');

insert into products (name, price)
values ('Fanta', null);


alter table products
    add column quantity varchar(10);

alter table products
    drop column quantity;

alter table products
    alter column price set data type integer;


alter table products
    alter column quantity drop default;

alter table products
    alter column quantity set data type integer
        using quantity::integer;

select *
from products;

insert into products (name, price, quantity)
VALUES ('Coke2', 15, 'qwerty');

select cast(quantity as integer)
from products;

select *
from products
where quantity = 'qwerty';


create table category
(
    id   serial primary key,
    name varchar(200)
);

alter table products
    add column category_id integer references category (id);

drop table category restrict;
drop table category cascade;



select name, price, id from products;