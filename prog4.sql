CREATE DATABASE day4;

use day4;

CREATE TABLE CUSTOMER(
customer_id INT PRIMARY KEY,
name VARCHAR(30) NOT NULL,
city VARCHAR(20)
);

create table ORDERS (
order_id INT PRIMARY KEY,
customer_id int,
foreign key(customer_id) references CUSTOMER(customer_id),
order_date DATE,
total int not null
);

create table ORDER_ITEMS(
order_id int,
foreign key(order_id) references ORDERS(order_id),
product_id int,
foreign key(product_id) references PRODUCT(product_id),
quantity int constraint check_value
check ( quantity > 0),
price int
);

create table PRODUCT(
product_id int primary key,
product_name varchar(15),
category varchar(15)
);


INSERT INTO PRODUCT (product_id, product_name, category) VALUES
(1, 'iPhone 13', 'Electronics'),
(2, 'Samsung TV', 'Electronics'),
(3, 'Nike Shoes', 'Fashion'),
(4, 'Laptop', 'Electronics'),
(5, 'T-shirt', 'Fashion'),
(6, 'Headphones', 'Electronics'),
(7, 'Watch', 'Accessories'),
(8, 'Backpack', 'Accessories'),
(9, 'Tablet', 'Electronics'),
(10, 'Sunglasses', 'Accessories');
INSERT INTO CUSTOMER VALUES
(1, 'Ravi Sharma', 'Delhi'),
(2, 'Anjali Singh', 'Mumbai'),
(3, 'Amit Das', 'Kolkata'),
(4, 'Sneha Roy', 'Kolkata'),
(5, 'Rahul Verma', 'Bangalore'),
(6, 'Priya Mehta', 'Chennai'),
(7, 'Arjun Patel', 'Ahmedabad'),
(8, 'Neha Kapoor', 'Delhi'),
(9, 'Karan Malhotra', 'Mumbai'),
(10, 'Pooja Sen', 'Kolkata');
INSERT INTO ORDERS (order_id, customer_id, order_date, total) VALUES
(101, 1, '2025-01-10', 50000),
(102, 2, '2025-01-12', 30000),
(103, 3, '2025-01-15', 1500),
(104, 4, '2025-01-16', 2000),
(105, 5, '2025-01-18', 45000),
(106, 6, '2025-01-20', 2500),
(107, 7, '2025-01-22', 3500),
(108, 8, '2025-01-25', 12000),
(109, 9, '2025-01-28', 8000),
(110, 10, '2025-02-01', 2200);
INSERT INTO ORDER_ITEMS (order_id, product_id, quantity, price) VALUES
(101, 1, 1, 50000),
(101, 6, 1, 2500),
(102, 2, 1, 30000),
(102, 7, 1, 3500),
(103, 5, 2, 750),
(103, 10, 1, 1100),
(104, 5, 1, 1000),
(104, 8, 1, 2000),
(105, 4, 1, 45000),
(105, 9, 1, 12000);

select C.customer_id,C.name,O.order_id,P.product_id,P.product_name,I.quantity,I.price
from CUSTOMER AS C
JOIN ORDERS AS O ON C.customer_id = O.customer_id
join ORDER_ITEMS AS I ON O.order_id = I.order_id
join PRODUCT AS P ON P.product_id = I.product_id;

select O.order_id, P.product_name
from ORDER_ITEMS AS O
JOIN PRODUCT AS P ON O.product_id = P.product_id;

select O.order_id, C.customer_id,C.name
from CUSTOMER AS C
JOIN ORDERS AS O ON C.customer_id = O.customer_id
where city ="KOLKATA";

select C.customer_id,C.name,sum(I.quantity * I.price) as Total_spent
from CUSTOMER AS C
JOIN ORDERS AS O ON C.customer_id = O.customer_id
join ORDER_ITEMS AS I ON O.order_id = I.order_id
group by C.customer_id;

select O.order_id,sum(quantity) as Item_Count
from ORDER_ITEMS AS O 
JOIN PRODUCT AS P ON P.product_id = O.product_id
group by O.order_id;

select * from PRODUCT;

select category,count(product_id) as No_of_Items
from PRODUCT 
GROUP BY category;

select sum(quantity*price) as Revenue
from ORDER_ITEMS;

select C.name 
from CUSTOMER AS C
LEFT JOIN ORDERS AS O ON C.customer_id = O.customer_id
where O.customer_id = NULL;

select order_id 
from ORDER_ITEMS
where quantity > 1;

select P.product_name,sum(O.quantity) as Total_orders 
from PRODUCT AS P 
JOIN ORDER_ITEMS AS O ON P.product_id = O.product_id
group by P.product_name
order by Total_orders desc
limit 1;

select P.category,sum(O.quantity * O.price) as Profit
from PRODUCT AS P 
JOIN ORDER_ITEMS AS O ON P.product_id = O.product_id
group by P.category
order by Profit desc
limit 1;

select C.name, sum(quantity * price) as Spent
from CUSTOMER AS C
JOIN ORDERS AS O ON C.customer_id = O.customer_id
join ORDER_ITEMS AS I ON O.order_id = I.order_id
group by I.order_id
order by Spent desc
limit 1;

select order_id,sum(quantity * price) as Total
from ORDER_ITEMS
group by order_id
having Total >(select avg(order_total) as Average
				from(select avg(quantity * price ) as order_total
					from ORDER_ITEMS
					group by order_id) as T
			   ); 
               
select C.name,I.order_id,sum(I.quantity * I.price) as Total
from CUSTOMER AS C
JOIN ORDERS AS O ON C.customer_id = O.customer_id
join ORDER_ITEMS as I on O.order_id = I.order_id
group by order_id
having Total >(select avg(order_total) as Average
				from(select avg(quantity * price ) as order_total
					from ORDER_ITEMS
					group by order_id) as T
			   ); 

