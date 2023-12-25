CREATE TABLE customers (
  customerid INTEGER PRIMARY KEY,
  name TEXT,
  country TEXT,
  gender TEXT
);

INSERT INTO customers (customerid,name, country, gender) 
  VALUES
  (1,'John Doe', 'USA', 'Male'),
  (2,'Jane Smith', 'Canada', 'Female'),
  (3,'David Johnson', 'UK', 'Male'),
  (4,'Emily Davis', 'Australia', 'Female'),
  (5,'Michael Brown', 'Germany', 'Male'),
  (6,'Sarah Wilson', 'France', 'Female'),
  (7,'James Lee', 'South Korea', 'Male'),
  (8,'Olivia Kim', 'South Korea', 'Female'),
  (9,'Daniel Kim', 'South Korea', 'Male'),
  (10,'Sophia Park', 'South Korea', 'Female');
  

.mode box
.header on  --ADDHEADER

SELECT * FROM customers;


CREATE TABLE menus (
  menuid INTEGER PRIMARY KEY,
  name TEXT,
  price REAL
);

INSERT INTO menus (menuid, name, price) 
VALUES
  (1, 'Cheese Pizza', 199),
  (2, 'Pepperoni Pizza', 199),
  (3, 'Salad', 149),
  (4, 'Pasta', 199),
  (5, 'French Fries', 99),
  (6, 'Coke', 69),
  (7, 'Burger', 149),
  (8, 'Chicken Wings', 179);

.mode box
.header on 

select * from menus;

create table orders (
  orderid INTEGER PRIMARY KEY,
  customerid INTEGER,
  menuid INTEGER,
  quantity INTEGER,
  total REAL,
  FOREIGN KEY (customerid) REFERENCES customers(customerid),
  FOREIGN KEY (menuid) REFERENCES menus(menuid)
);

INSERT INTO orders (orderid, customerid, menuid, quantity, total)
VALUES 
  (1, 1, 5, 2, 198),
  (2, 2, 1, 2, 398),
  (3, 2, 6, 4, 276),
  (4, 5, 5, 1, 99),
  (5, 5, 1, 3, 199),
  (6, 6, 6, 1, 69),
  (7, 4, 2, 4, 796),
  (8, 8, 3, 8, 447),
  (9, 8, 6, 7, 483),
  (10, 9, 5, 5, 495),
  (11, 7, 5, 2, 198),
  (12, 7, 6, 1, 69),
  (13, 3, 2, 2, 398),
  (14, 3, 6, 1, 69);

.mode box
.header on
select * from orders;

select 
  A.name ,
  A.country,
  C.name,
  B.quantity,
  B.total
from customers A 
join orders B on A.customerid = B.customerid
join menus C on B.menuid = C.menuid
;

select
  name,
  country
from(select * from customers)
where country = 'USA';

select 
  customers.name,
  customers.country,
  orders.customerid,
  orders.total,
  menus.name
from orders
join menus on orders.menuid = menus.menuid
join customers on orders.customerid = customers.customerid 
where orders.menuid = 5;

with t1 as (select
  customerid,
  name,
  country  
from customers
where country = 'Italy'),
t2 as (select 
  customerid,
  menuid,
  total 
from orders
where menuid = 5),
t3 as (select *
from menus)

select 
  t1.name,
  country,
  t3.name, 
  total 
from t1
join t2 on t1.customerid = t2.customerid
join t3 on t2.menuid = t3.menuid
;

select 
  A.name          as cus_name,
  A.country       as cus_country,
  C.name          as menu_name,
  B.quantity      as quantity,
  B.total         as total,
  sum(B.total)    as sum_total
from customers A 
join orders B on A.customerid = B.customerid
join menus C on B.menuid = C.menuid
group by 1, 2, 3 

;
