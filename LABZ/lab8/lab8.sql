create table countries(
    name varchar(200)
);
insert into countries values ('aaa');
insert into countries values ('string');
insert into countries values ('bb');
insert into countries values ('b');
insert into countries values ('cc');

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer
);
create table employee(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    salary integer,
    department_id integer references departments
);

--1. Create index for queries like below SELECT * FROM countries WHERE name = ‘string’;
create index  idx_countries_name on countries (name);

--2. Create index for queries like below: SELECT * FROM employees WHERE name = ‘string’ AND surname = ‘string’;
create index idx_empolyee on employee (first_name, last_name);

--3. Create unique index for queries like below: SELECT * FROM employees WHERE salary < value1 AND salary > value2;
create unique index idx_empolyee_uni on employee(salary);

--4. Create index for queries like below: SELECT * FROM employees WHERE substring(name from 1 for 4) = ‘abcd’;
create index subs_idx_employee on employee ((substring(first_name from 1 for 4)));

--5. Create index for queries like below: SELECT * FROM employees e JOIN departments d ON d.department_id = e.department_id WHERE d.budget > value2 AND e.salary < value2;
create index idx_employees_department_id_salary on employee (department_id, salary);
create index idx_departments_department_id_budget on departments (department_id, budget);
