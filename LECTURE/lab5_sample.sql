select *
from film
where length > 100
   or rental_duration > 3;


select *
from film
where rental_duration <> 3


select *
from film
where length between 100 and 120;


select *
from film
where length >= 100
  and length <= 120;


select *
from film
where length not between 100 and 120;


select *
from film
where length < 100
   or length > 120;



select *
from film
where length between symmetric 120 and 100;

select *
from film
where length not between symmetric 120 and 100;


select *
from address
where address2 is distinct from null;

select *
from address
where address2 != null;


select *
from address
where address2 is null;

select *
from address
where address2 is not null;


select *,
       num_nonnulls(address, address2, district),
       num_nulls(address, address2, district)
from address
order by address2;


select rental_rate,
       abs(rental_rate),
       ceil(rental_rate),
       floor(rental_rate),
       round(rental_rate, 2),
       trunc(rental_rate, 1)
from film;


select random() * 100;

select first_name || ' ' || last_name || ' ' || actor_id fullname
from actor;

select first_name,
       bit_length(first_name),
       char_length(first_name),
       octet_length(first_name)
from actor;



select first_name,
       overlay(first_name placing 'AAA' from 2 for 3),
       position('CAR' in first_name),
       substring(first_name from 2 for 3),
       substring(first_name, 2, 3),
       trim(trailing 'AB' from first_name)
from actor;



select format('The fullname of actor with id %s is %s %s', actor_id, first_name, last_name)
from actor;


select *
from actor
where first_name like '_A%';
select *
from actor
where first_name like '%A%';
select *
from actor
where first_name like '__A%';


select to_char(length, '999999')
from film;
select to_char(rental_rate, '999D99')
from film;
select to_char(rental_rate, '999D99')
from film;
select to_char(last_update, 'DD:MM:YYYY HH:MI:SS')
from film;



select title,
       length,
       case
           when length < 80 then 'Short length'
           when length < 100 then 'Mid length'
           else 'Long length'
           end string_length
from film;



select title,
       length,
       case length
           when 80 then 'First length'
           when 100 then 'Second length'
           else 'Other length'
           end string_length
from film;



select coalesce(null, null, 1, null, 2);
select coalesce(title_kk, title_ru, title_en, 'Empty title');

select nullif(1, 2);


select greatest(1, 2, 4, 5, 1), least(1, 2, 4, 5, 1);


select rental_duration, rental_rate, greatest(rental_duration, rental_rate)
from film;


select *
from unnest(array [1, 2 , 5], array [1, 2 , 5]);



select *
from city
where exists(select address.city_id
             from address
             where address.city_id = city.city_id
             group by address.city_id
             having count(*) >= 2);


select *
from city
where city_id in (select city_id
                  from address
                  group by address.city_id
                  having count(*) >= 2);



select *
from city
where city_id > any (select city_id
                     from address
                     group by address.city_id
                     having count(*) >= 2);


10 > any (11, 12, 13, 10) = false
10 > any (11, 12, 13, 9) = true


10 > all (11, 12, 13, 9) = false
10 > all (8, 7, 9, 9) = true
10 = all (10, 10, 10, 10) = true






