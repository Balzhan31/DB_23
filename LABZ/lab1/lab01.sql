create database lab1;

create table users(
    id serial primary key,
    firstname varchar(50),
    lastname varchar(50)
);

alter table users
add  column isadmin integer;

alter table users
alter column isadmin set data type boolean;

alter table users
alter column isadmin set default false;

alter table users
add constraint users_id primary key (id);

select *
from users;

create table users(
    id serial primary key,
    name varchar(50),
    user_id integer
);

drop table tasks;

drop database lab1;

select *
from users;
