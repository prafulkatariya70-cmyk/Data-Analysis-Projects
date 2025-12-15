CREATE TABLE orders_dates (
    order_id INT,
    customer_name VARCHAR(50),
    order_date DATETIME,
    delivery_date DATE
);

INSERT INTO orders_dates VALUES
(1, 'Amit',   '2024-12-01 10:30:00', '2024-12-05'),
(2, 'Neha',   '2024-12-02 14:45:00', '2024-12-06'),
(3, 'Rahul',  '2024-12-03 09:15:00', '2024-12-07'),
(4, 'Ananya', '2024-12-04 18:20:00', '2024-12-08');

SELECT * FROM orders_dates

--Current date & time
select getdate() as current_datetime;

--Current date only
select cast(getdate() as date) as todays_date;

--Extract parts from date
select order_id,year(order_date) as order_year
from orders_dates

select order_id,month(order_date) as ordered_month
from orders_dates

select order_id,day(order_date) as ordered_day
from orders_dates

-- Days between order and delivery

select order_id,
datediff(day,order_date,delivery_date) as delivery_days
from orders_dates

--Add 7 days to order date(expected delivery)
select order_id,
dateadd(day,7,order_date) as expected_delivery
from orders_dates

--Find orders placed in December

select * from orders_dates
where month(order_date)=12;

-- Find orders placed in 2024

select * from orders_dates
where year(order_date)=2024;

--Find orders delivered in more than 3 days

select * from orders_dates
where datediff(day,order_date,delivery_date)>3

--Display order_id and only order date (no time)
select order_id,
cast(order_date as date) as order_date
from orders_dates

--Show today’s date and time
select getdate() as current_datetime;

--Extract year and month from order_datetime
SELECT order_id,
       YEAR(order_datetime) AS order_year,
       MONTH(order_datetime) AS order_month
FROM orders_time;

--Find orders where delivery took more than 4 days
select * from orders_dates
where datediff(day,order_date,delivery_date)>4;

--Show order_id, month name, and day name
select order_id,
datename (month,order_date) as month_name,
datename(weekday,order_date) as day_name
from orders_dates

--Find orders placed between 1 Dec 2024 and 3 Dec 2024
select * from orders_dates
where order_Date>='2024-12-01' and order_date< '2024-12-04';

--Categorize orders using CASE WHEN
select order_id,
datediff(day,order_date,delivery_date) as delivery_time,
case 
when datediff(day,order_date,delivery_date)<=4 then 'slow'
else 'fast'
end as delivery_speed
from orders_Dates;