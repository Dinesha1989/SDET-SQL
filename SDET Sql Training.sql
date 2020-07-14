create database Dinesh_Activities;

create table salesman (salesman_id int PRIMARY KEY, name varchar(20), city varchar(20), commission int);

describe salesman;

insert into salesman (salesman_id, name, city, commission )
	   values ('5001', 'James Hoog', 'New York', '15'),
              ('5002', 'Nail Knite', 'Paris', '13'),
			  ('5005', 'Pit Alex', 'London', '11'),
              ('5006', 'McLyon', 'Paris', '14'),
              ('5007', 'Paul Adam', 'Rome', '13'),
              ('5003', 'Lauson Hen', 'San Jose', '12');
              
select * from salesman;
select salesman_id, city from salesman; 
select * from salesman where city = 'Paris';

select salesman_id, commission  from salesman where name = 'Paul Adam';
 
ALTER TABLE orders1
RENAME TO orders;

ALTER table salesman Add grade int;

update salesman set grade = '100';

select * from salesman;

update salesman set grade = '200' where city = 'Rome';

update salesman set grade = '300' where name = 'James Hoog';

update salesman set name = 'Pierre' where salesman_id = '5006';

create table Dinesh_Activities.orders(order_no int, purchase_amount float, order_date date,
    customer_id int PRIMARY KEY, salesman_id int);
    
desc orders;

insert into orders values
(70001, 150.5, '2012-10-05', 3006, 5002), (70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001), (70004, 110.5, '2012-08-17', 3012, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002), (70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-08-15', 3003, 5001), (70010, 1983.43, '2012-10-10', 3010, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003), (70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3004, 5007), (70013, 3045.6, '2012-04-25', 3011, 5001);    

select * from orders;
select distinct salesman_id from orders;
select order_no, order_date from orders order by order_date;
select order_no, purchase_amount from orders order by purchase_amount DESC;
select * from orders where purchase_amount<500;
select * from orders where purchase_amount between 1000 and 2000;


select sum(purchase_amount) from orders;
select avg(purchase_amount) from orders;
select max(purchase_amount) from orders;
select min(purchase_amount) from orders;
select count(distinct salesman_id) from orders;

select customer_id, max(purchase_amount) as 'Max Amount' from orders group by customer_id order by purchase_amount;

select salesman_id, order_date, max(purchase_amount) as 'Max Amount' from orders where order_date = '2012-08-17' group by salesman_id, order_date;

select customer_id, order_date, max(purchase_amount) as 'Max Amount' from orders group by customer_id, order_date having max(purchase_amount) in (2000,3000,5760,6000);

-- Create the customers table
create table customers (
    customer_id int primary key, customer_name varchar(32),
    city varchar(20), grade int, salesman_id int);

-- Insert values into it
insert into customers values 
(3002, 'Nick Rimando', 'New York', 100, 5001), (3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002), (3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006), (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007), (3001, 'Brad Guzan', 'London', 300, 5005);

select * from customers;
select * from salesman;
select * from orders;

select customer_name, name from customers inner join salesman where customers.salesman_id = salesman.salesman_id;

SELECT a.customer_name, a.city, a.grade, b.name AS "Salesman", b.city FROM customers a 
LEFT OUTER JOIN salesman b ON a.salesman_id=b.salesman_id WHERE a.grade<300 
ORDER BY a.customer_id;

select customer_name, name as "salesman", commission from customers inner join salesman on customers.salesman_id = salesman.salesman_id where commission>12;

select order_no, order_date, purchase_amount, customer_name, name as "salesman", commission from orders 
inner join customers on orders.customer_id = customers.customer_id
inner join salesman on orders.salesman_id = salesman.salesman_id;

select order_no, customer_id, salesman_id from orders where salesman_id in (select distinct salesman_id from orders where customer_id = '3007');

select order_no, salesman_id from orders where salesman_id in (select distinct salesman_id from salesman where city='New York');
 
select grade, count(*) from customers group by grade having grade > (select avg(grade) from customers where city = 'New York');

-- select order_no, salesman_id, name as "salesman", max(commission) from orders inner join salesman on orders.salesman_id = salesman.salesman_id group by commission;

SELECT order_no, purchase_amount, order_date, salesman_id FROM orders
WHERE salesman_id IN( SELECT salesman_id FROM salesman
WHERE commission=( SELECT MAX(commission) FROM salesman));


                       
                        