select;

select actor_id as "Actor ID", first_name
from actor;

select *
from actor;


select 1 + 1 as sum;

select lower('HELLO') as "Lower hello", upper('hello');


select *
from actor;

select all count(*)
from actor;

select distinct count(*)
from actor;

select distinct on (first_name, last_name) actor_id, first_name, last_name
from actor;


select *
from actor
where first_name = 'JON';


select rental_duration, rental_rate, avg(length), max(length), count(*)
from film
group by rental_duration, rental_rate;

select length
from film
where rental_duration = 4;


select rental_duration, rental_rate, avg(length), max(length), count(*)
from film
group by rental_duration, rental_rate
having count(*) > 70;



select rental_duration, rental_rate, avg(length), max(length), count(*)
from film
where length > 150
group by rental_duration, rental_rate
having count(*) > 20;

select count(*)
from film
where length > 150

select count(*)
from film
where rental_rate > 3

select 336 + 242; -- 578
select 578 - 495;

select *
from film
where length > 150
union
distinct
select *
from film
where rental_rate > 3;


select *
from film
where length > 150
union all
select *
from film
where rental_rate > 3;



select *
from film
where length > 150
   or rental_rate > 3;



select rental_duration, rental_rate
from film
where length > 150
intersect
distinct
select rental_duration, rental_rate
from film
where rental_rate > 3;


select rental_duration, rental_rate
from film
where length > 150
intersect
    all
select rental_duration, rental_rate
from film
where rental_rate > 3;



select rental_duration, rental_rate
from film
where length > 150
  and rental_rate > 3;



select rental_duration, rental_rate
from film
where length > 150
except
distinct
select rental_duration, rental_rate
from film
where rental_rate > 3;


select rental_duration, rental_rate
from film
where length > 150
except
    all
select rental_duration, rental_rate
from film
where rental_rate > 3;


select *
from film
where length > 150
  and rental_rate <= 3;



select *
from film
order by length desc, replacement_cost + rental_rate;



select *
from address
order by address2 asc nulls first;

select *
from address
order by address2 desc nulls last;



select *
from actor
limit 10;

select first_name
from actor
where actor_id < 20
group by first_name
limit 10 offset 20;


select rental_duration
from film
group by rental_duration
limit 10;


select distinct on (length) *
from film
order by length desc
limit 1 offset 2;

