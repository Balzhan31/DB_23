--1. Write a stored procedure named increase_value that takes one integer parameter and returns the parameter value increased by 10.
create function increase_value(val integer) returns integer as
$$
begin
    return val + 1;
end;
$$
    language plpgsql;
select increase_value(10);

--2. Create a stored procedure compare_numbers that takes two integers and returns 'Greater', 'Equal', or ‘Lesser' as an out parameter, depending on the comparison result of these two numbers.
create or replace function compare_numbers(num1 integer,
                                           num2 integer,
                                           out result varchar (50)) as
$$
begin
    if(num1 > num2) then result := 'Greater';
    elsif(num1 < num2) then result := 'Lesser';
    else result := 'Equal';
    end if;
end;
$$lab9
    language plpgsql;
select compare_numbers(1, 2);

--3. Write a stored procedure number_series that takes an integer n and returns a series from 1 to n. Use a looping construct within the procedure.
create or replace function number_series(n integer) returns setof integer as
$$
declare
    "counter" int := 1;
begin
   for counter in 1..n loop
        return next counter;
    end loop;
    return;
end;
$$
    language plpgsql;
select number_series(4);

--4. Write a stored procedure find_employee that takes an employee name as a parameter and returns the employee details by performing a query.
create table employee(
    first_name varchar(50),
    last_name varchar(50),
    salary integer
);
insert into employee(first_name, last_name, salary) values ('Balzhan', 'Bozbashayeva',  6000);
insert into employee(first_name, last_name, salary) values ('Zhanel', 'Amanzhol',  4000);

create or replace function find_employee(e_name varchar(50)) returns setof employee as
$$
begin
return query select * from employee where first_name = e_name;
end;
$$
    language plpgsql;
select * from find_employee('Balzhan');

--5. Develop a stored procedure list_products that returns a table with product details from a given category.
create table orders(
    ord_num serial primary key,
    purch_amt decimal(8, 2),
    ord_date date
);
insert into orders (ord_num, purch_amt, ord_date) values (70001, 150.5, '2012-10-05');
insert into orders (ord_num, purch_amt, ord_date) values (70009, 270.65, '2012-09-10');

create or replace function list_products(p_num integer) returns table(
    ord_no integer,
    purch_amt float,
    ord_date date
) as $$
begin
    return query
    select o.ord_num, o.purch_amt, o.ord_date from orders o where o.ord_num = p_num;
end;
$$ language plpgsql;
select * from list_products(70001);


--6. Create two stored procedures where the first procedure calls the second one. For example, a procedure calculate_bonus
-- that calculates a bonus, and another procedure update_salary that uses calculate_bonus to update the salary of an employee.
create table employees(
    employee_id int,
    first_name varchar(50),
    last_name varchar(50),
    salary integer
);
create or replace function calculate_bonus(e_id integer, out bonus decimal(5, 2)) returns numeric as $$
begin
    bonus := 1.1;
end;
$$ language plpgsql;

create or replace function update_salary(e_id integer, out bonus decimal(5, 2)) returns numeric as $$
begin
    perform calculate_bonus(e_id);
    update employees set salary = salary + (salary * bonus) where employee_id = e_id;
end;
$$ language plpgsql;

select * from calculate_bonus(2);
select * from update_salary(1);

--7
create or replace function complex_calculation(
    param_one integer,
    param_two varchar(50),
    OUT final_result varchar(100)
) as $$
declare
    result_1 VARCHAR(50);
begin
    begin
        declare
            result_2 INTEGER;
        begin
            result_1 := 'The result of ' || param_two ||  ' operation';
            result_2 := param_one * 2;
            final_result := result_1 || 'is' ||  result_2::VARCHAR;
        end;
    end;
end;
$$ language plpgsql;

select * from complex_calculation(2, 'first');

