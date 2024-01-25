create database lab2
    with owner postgres;
  --  At least 3 DDL commands.
  --  At least 4 DML commands.
  -- DDL 1
  create table info(
      name varchar(25) not null,
      last_name varchar(25) not null,
      age integer not null,
      gender varchar(6)
  );
  -- DDL 2
  alter table info
  add column birth_date date;
  -- DML 1
  insert into info values ( 'Balzhan', 'Bozbashayeva', 18, 'Female', to_date('31/03/2005', 'dd/mm/yyyy'));
  insert into info values ( 'Zhanel', 'Amanzhol', 18, 'Female', to_date('28/08/2005','dd/mm/yyyy'));
  -- DML 2
  delete from info where gender = 'Male';
  -- DML 3
  update info set last_name ='Talgatkyzy' where name = 'Balzhan';
  -- DML 4
  select *
  from info;
  -- DDL 3
  drop table info;


--  Write SQL statements to create tables as shown in the figure below.
create table depertments(
    dept_no char(4) primary key,
    dept_name varchar(40)
);

create table employess(
    emp_no integer primary key,
    birth_date date,
    first_name varchar(14),
    last_name varchar(16),
    gender char(6),
    hire_date date
);

create table titles(
    emp_no integer,
    title varchar(50),
    from_date date,
    to_date date,
    foreign key (emp_no) references employess(emp_no)
);

create table salaries(
    emp_no integer,
    salary integer,
    from_date date,
    to_date date,
    foreign key (emp_no) references employess(emp_no)
);

create table  dept_emp(
    emp_no integer,
    dept_no char(4),
    from_date date,
    to_date date,
    foreign key (emp_no) references employess(emp_no),
    foreign key (dept_no) references depertments(dept_no)
 );

create table dept_manager(
    dept_no char(4),
    emp_no integer,
    from_date date,
    to_date date,
    foreign key (emp_no) references employess(emp_no),
    foreign key (dept_no) references depertments(dept_no)
);

  -- Write SQL statements describing tables
  -- with appropriate data types and constraints that satisfy the following
  -- conditions (you may need additional tables to store data atomically and efficiently): --
  create table students(
      student_id serial primary key,
      full_name varchar(150) not null,
      age integer,
      birth_date date,
      gender varchar(6),
      average_grade decimal(1, 2),
      nationality varchar(50),
      phone_number varchar(15),
      social_category varchar(50),
      check ( age >= 0 ),
      check ( average_grade >= 0 and average_grade <= 50 )
  );

  create table instructors(
      instructor_id serial primary key,
      age integer not null,
      full_name varchar(50) not null,
      spoken_language varchar(50),
      work_exp integer,
      lessons boolean,
      check ( work_exp > 0 and work_exp < age )
  );

  create table student_relatives(
      student_id serial primary key,
      full_name varchar(50) not null,
      address varchar(50),
      phone_number varchar(15),
      position varchar(50),
      foreign key (student_id) references students(student_id)
  );

  create table student_social_data(
    student_id serial primary key,
    school varchar(50),
    grad_date date,
    address varchar(50),
    region varchar(50),
    country varchar(50),
    GPA decimal(1, 2),
    honors text,
    check ( GPA > 0 and GPA < 4.00 ),
    foreign key (student_id) references students(student_id)
  );

 --Provide examples of insertion, update, and deletion of data in the tables from exercise 2.
insert into departments (dept_no, dept_name)
values ( '01', 'HR');
insert into employess (birth_date, first_name, last_name, gender, hire_date)
values ('2002/11/15', 'Jake', 'Shin', 'Male', '2020/06/1');
insert into titles (emp_no, title, from_date, to_date)
values (1, 'Manager', '2022/05/10', '2023/08/25');
insert into salaries (emp_no, salary, from_date, to_date)
values (1, 100000, '2022/05/10', '2023/05/12');
select * from salaries;
insert into dept_emp (emp_no, dept_no, from_date, to_date)
values (1, '01', '2022/05/10', '2023/05/10');
insert into dept_manager (dept_no, emp_no, from_date, to_date)
values ('01', 1, '2022/05/10', '2023/05/10');

update employess
set first_name = 'Jane', last_name = 'Joni'
where emp_no = 1;

update titles
set title = 'Junior Manager'
where emp_no = 1;

delete from employess
where emp_no = 1;

delete from departments
where dept_no = '01';







