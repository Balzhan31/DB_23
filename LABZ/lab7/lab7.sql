create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    commission float
);

INSERT INTO dealer (id, name, location, commission) VALUES (101, 'Oleg', 'Astana', 0.15);
INSERT INTO dealer (id, name, location, commission) VALUES (102, 'Amirzhan', 'Almaty', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (105, 'Ademi', 'Taldykorgan', 0.11);
INSERT INTO dealer (id, name, location, commission) VALUES (106, 'Azamat', 'Kyzylorda', 0.14);
INSERT INTO dealer (id, name, location, commission) VALUES (107, 'Rahat', 'Satpayev', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (103, 'Damir', 'Aktobe', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Bekzat', 'Satpayev', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Aruzhan', 'Almaty', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Almaty', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Yerkhan', 'Taraz', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Aibek', 'Kyzylorda', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Arsen', 'Taldykorgan', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Alen', 'Shymkent', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Zhandos', 'Astana', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2021-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2021-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2021-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2021-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2021-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2021-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2021-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2021-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2021-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2021-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2021-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2021-04-25 00:00:00.000000', 802, 101);

--Task 1
--a. find those clients with a priority less than 300
select c.id, c.name, c.priority, d.name
from client c
join dealer d on d.id = c.dealer_id
where c.priority < 300;

--b. combine each row of dealer table with each row of client table
select *
from dealer
cross join client;

--c. find all dealers along with client name, city, priority, sell number, date, and amount
select d.name, c.name, c.city, c.priority, s.id, s.date, s.amount--
from dealer d
join client c on d.id = c.dealer_id
join sell s on c.id = s.client_id;

--d. find the dealer and client who reside in the same city
select d.name,d.location, c.name, c.city
from dealer d
join client c on d.id = c.dealer_id
where d.location = c.city;

--e. find sell id, amount, client name, city those sells where sell amount exists between 200 and 500.
select s.id, s.amount, c.name, c.city
from sell s
join client c on s.client_id = c.id
where s.amount between 200 and 500;

--f. find dealers who works either for one or more client or not yet join under any of the clients.
select d.name, count(c.id) as client_num
from client c
right join dealer d on d.id = c.dealer_id
group by d.name;

--g. find the dealers and the clients he service, return client name, city, dealer name, commission.
select c.name, c.city, d.name, d.commission
from client c
join dealer d on c.dealer_id = d.id;

--h. find client name, client city, dealer, commission those dealers who received a commission from the sell more than 13%.
select c.name, c.city, d.name, d.commission
from client c
join dealer d on d.id = c.dealer_id
where d.commission > 0.13;

--i. make a report with clienjt name, city, sell id, sell date, sell amount, dealer name and commission to find that either
-- any of the existing clients haven’t made a purchase(sell) or made one or more purchase(sell) by their dealer or by own.
select c.name, c.city, s.id, s.date, s.amount, d.name, d.commission
from client c
left join sell s on c.id = s.client_id
left join dealer d on c.dealer_id = d.id;

--j. find dealers who either work for one or more clients. The client may have made, either one or more purchases, or purchase
-- amount above 2000 and must have a priority, or he may not have made any purchase to the associated dealer. Print client name,
-- client priority, dealer name, sell id, sell amount.
select c.name, c.priority, d.name, s.id, s.amount
from client c
join dealer d on d.id = c.dealer_id
left join sell s on c.id = s.client_id
where s.amount > 2000 and c.priority is not null;


--Task 2
--a. count the number of unique clients, compute average and total purchase amount of client orders by each date.
create view A as
select date, count(distinct client_id), avg(amount), sum(amount)
from sell group by date;
select * from A;

--b. find top 5 dates with the greatest total sell amount.
create view B as
select date, sum(amount)
from sell group by date order by sum(amount) desc limit 5;
select * from B;

--c. count the number of sales, compute average and total amount of all sales of each dealer.
create view C as
select dealer_id, count(*), avg(amount), sum(amount)
from sell group by dealer_id;
select * from C;

--d. compute how much all dealers earned from commission (total sell amount *commission) in each location.
create view D as
select d.location, sum(s.amount * d.commission) as total
from dealer d
left join client c on d.id = c.dealer_id
left join sell s on c.id = s.client_id
group by d.location);
select * from D;

--e. compute number of sales, average and total amount of all sales dealers made in each location.
create view E as
select d.location, count(sell.id), avg(amount), sum(amount)
from sell
join dealer d on sell.dealer_id = d.id
group by d.location;
select * from E;

create view e2(location, sal_number_of_sales, sal_average_amount, sal_total_amount) as
select  d.location, count(sell.id), avg(amount), sum(amount)
from sell
join dealer d on sell.dealer_id = d.id
group by d.location;
select from e2;

--f.compute number of sales, average and total amount of expenses in each city clients made.
create view F as
select c.city, count(sell.id), avg(amount), sum(amount)
from sell
join client c on c.id = sell.client_id
group by c.city;
select * from F;

create view f2(city, exp_number_of_sales, exp_average_amount, exp_total_amount) as
select c.city, count(sell.id), avg(amount), sum(amount)
from sell
join client c on c.id = sell.client_id
group by c.city;
select * from f2;

--g. find cities where total expenses more than total amount of sales in locations.
create view G as
select * from e2
join f2 on e2.location = f2.city
where f2.exp_total_amount > e2.sal_total_amount;
select * from g;