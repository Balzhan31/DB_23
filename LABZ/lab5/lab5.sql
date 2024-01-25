create database lab5;

create table customers(
    customer_id serial primary key,
    cust_name varchar(200),
    city varchar(200),
    grade integer,
    salesman_id integer
);

create table orders(
    ord_no serial primary key,
    purch_amt decimal(8, 2),
    ord_date date,
    customer_id integer,
    salesman_id integer
);

insert into customers(customer_id, cust_name, city, grade, salesman_id) values (3002, 'Nick Rimando', 'New York', 100, 5001);
insert into customers(customer_id, cust_name, city, grade, salesman_id) values (3005, 'Graham Zusi', 'California', 200, 5002);
insert into customers(customer_id, cust_name, city, grade, salesman_id) values (3001, 'Brad Guzan', 'London', null, 5005);
insert into customers(customer_id, cust_name, city, grade, salesman_id) values (3004, 'Fabian Johns', 'Paris', 300, 5006);
insert into customers(customer_id, cust_name, city, grade, salesman_id) values (3007, 'Brad Davis', 'New York', 200,5001 );
insert into customers(customer_id, cust_name, city, grade, salesman_id) values (3009, 'Geoff Camero', 'Berlin', 100, 5003);
insert into customers(customer_id, cust_name, city, grade, salesman_id) values (3008, 'Julian Green', 'London', 300, 5002);

insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70001, 150.5, '2012-10-05', 3005, 5002);
insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70009, 270.65, '2012-09-10', 3001, 5005);
insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70002, 65.26, '2012-10-05', 3002, 5001);
insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70004, 110.5, '2012-08-17', 3009, 5003);
insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70007, 948.5, '2012-09-10', 3005, 5002);
insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70005, 2400.6, '2012-07-27', 3007, 5001);
insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values (70008, 5760, '2012-09-10', 3002, 5001);

--3 Select the total purchase amount of all orders.
select sum(purch_amt) as summary
from orders;

--4 Select the average purchase amount of all orders.
select avg(purch_amt) as avr_purch
from orders;

--5 Select how many customer have listed their names.
select count(distinct cust_name) as name
from customers;

--6 Select the minimum purchase amount of all the orders.
select min(purch_amt) as mini
from orders;

--7 Select customer with all information whose name ends with the letter 'b'.
select cust_name
from customers
where cust_name like '%b';

--8 Select orders which made by customers from ‘New York’.
select *
from orders
where customer_id in (select customer_id
                      from customers
                      where city = 'New York');

--9 Select customers with all information who has order with purchase amount more than 10.
select *
from customers
where customer_id in (select customer_id
                      from orders
                      where purch_amt > 10);

--10  Select total grade of all customers.
select sum(grade) as tot_grade
from customers;

--11 Select all customers who have listed their names.
select *
from customers
where cust_name is not null;

--12 Select the maximum grade of all the customers.
select max(grade) as maxi
from customers;




