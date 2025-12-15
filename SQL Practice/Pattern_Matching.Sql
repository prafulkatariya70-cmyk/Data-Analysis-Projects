--PATTERN MATCHING --
CREATE TABLE onlinne_orders (
    order_id INT,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    city VARCHAR(50),
    order_status VARCHAR(20)
);
INSERT INTO onlinne_orders VALUES
(1, 'Amit',     'Laptop',     'Mumbai',     'Delivered'),
(2, 'Neha',     'Mobile',     'Delhi',      'Pending'),
(3, 'Rahul',    'Headphones', 'Pune',       'Delivered'),
(4, 'Ananya',   'Keyboard',   'Bangalore',  'Cancelled'),
(5, 'Arjun',    'Mouse',      'Mumbai',     'Delivered'),
(6, 'Sneha',    'Monitor',    'Chennai',    'Pending'),
(7, 'Rohit',    'Laptop',     'Delhi',      'Delivered'),
(8, 'Pooja',    'Tablet',     'Pune',       'Cancelled'),
(9, 'Nikhil',   'Mobile',     'Bangalore',  'Delivered'),
(10,'Aakash',   'Charger',    'Ahmedabad',  'Pending'),
(11,'Meena',    'Printer',    'Jaipur',     'Delivered'),
(12,'Suresh',   'Scanner',   'Surat',      'Cancelled'),
(13,'Kiran',    'Speaker',   'Indore',     'Delivered'),
(14,'Rina',     'Webcam',    'Noida',      'Pending'),
(15,'Ankit',    'Router',    'Nagpur',     'Delivered');

select * from onlinne_orders

--Name starting with 'A'
select * from onlinne_orders
where customer_name like 'A%';

--Name ending with 'A'
select * from onlinne_orders
where customer_name like '%A';

--City containing del
select * from onlinne_orders
where city like '%del%';

-- Product with exactly 6 letters
select * from onlinne_orders
where product_naME LIKE '______';

--City starting with B and ending with e
select * from onlinne_orders
where city like 'B%e';

--NOT LIKE --
--Customers NOT starting with A

select * from onlinne_orders
where customer_name not like 'A%'

--Second letter is 'e'
select * from onlinne_orders
where customer_name like '_e%';

--City with exactly 5 letters
select * from onlinne_orders
where city like'_____';

--Product name contains “top”
select * from onlinne_orders
where product_name like '%top%'

--Status ends with “ed”
select * from onlinne_orders
where order_status like '%ed'

--Orders placed in December 2024
select * from onlinne_orders
where order_id like '__'

--Find customers whose name looks incomplete or suspicious
select * from onlinne_orders
where customer_name like '_%';

--Find orders from metro cities
select * from onlinne_orders
where city like 'D%'
or city like 'M%'
or city like 'C%'

--Identify electronics-related products
select * from onlinne_orders
where product_name like '%top%'
or product_name like '%monitor%'
or product_name like '%mobile%';

--Find orders that are not yet completed
select * from onlinne_orders
where order_status  like '%ng'

--Detect city name spelling issues
select * from onlinne_orders
where city like '% %'

--Identify test / dummy customer records
select * from onlinne_orders
where customer_name like '%test%'
or customer_name like '%demo%'
or customer_name like '%sample%'

--Find customers likely ordering from mobile devices
select * from onlinne_orders
where product_name like '%mobile%'
or product_name like '%tablet%'

--Detect delivery failures or cancellations
select * from onlinne_orders
where order_Status like '%cancel%'
or order_Status like '%fail%'

