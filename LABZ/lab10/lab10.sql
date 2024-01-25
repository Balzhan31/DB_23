
create table books(
    book_id integer primary key,
    title varchar(200),
    author varchar(200),
    price decimal(10, 2),
    quantity integer
);

create table orders(
    order_id integer primary key,
    book_id integer references books(book_id),
    customer_id integer,
    order_date date,
    quantity integer
);

create table customers(
    customer_id integer primary key,
    name varchar(200),
    email varchar(200)
);

insert into books(book_id, title, author, price, quantity) values (1, 'Databases 101', 'A.Smith', 40.00, 10);
insert into books(book_id, title, author, price, quantity) values (2, 'Learn SQL', 'B. Johnson', 35.00, 15);
insert into books(book_id, title, author, price, quantity) values (3, 'Advanced DB', 'C. Lee', 50.00, 5);

insert into customers(customer_id, name, email) values (101, 'John Doe', 'johndoe@example.com');
insert into customers(customer_id, name, email) values (102, 'Jone Doe', 'janedoe@example.com');


--1.Transaction for Placing an Order
start transaction;

insert into orders (book_id, customer_id, order_date, quantity)
values (1, 101, current_date, 2);

update books SET quantity = quantity - 2 where book_id = 1;

commit;


--2.Transaction with Rollback
start transaction;

savepoint before_insert;

insert into Orders (book_id, customer_id, order_date, quantity)
values (3, 102, current_date, 10);

select quantity from books where book_id = 3 for update;

rollback to before_insert;


--3.Isolation Level Demonstration
-- Session 1
set transaction isolation level read committed;

start transaction;

update books set price = price + 5 where book_id = 2;

commit;

-- Session 2
set transaction isolation level read committed;

start transaction ;

select price from books where book_id = 1;

commit;


--4.Durability Check
start transaction ;

update customers set email = 'newemail@example.com' where customer_id = 101;

commit;

select * from customers where customer_id = 101;





