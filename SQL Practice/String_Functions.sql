-- LENGTH --
select len ('india')
select len('   india  ')

CREATE TABLE onlinne_orders (
    order_id INT,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    city VARCHAR(50),
    order_status VARCHAR(20)
);


INSERT INTO onlinne_orders
VALUES
(1, 'Amit', 'Laptop', 'Mumbai', 'Delivered'),
(2, 'Neha', 'Mobile', 'Delhi', 'Pending'),
(3, 'Rahul', 'Headphones', 'Pune', 'Delivered'),
(4, 'Ananya', 'Keyboard', 'Bangalore', 'Cancelled');

select * from onlinne_orders

--Length of customer names
select customer_name, len(customer_name) as name_length
from onlinne_orders

--Orders where product name length > 6
select * from onlinne_orders
where len(product_name)>6;

--Cities with short names (≤ 5 chars)
select city from onlinne_orders
where len(city)<=5;

--UPPER LOWER --
--UPPER() → converts text to CAPITAL letters
--LOWER() → converts text to small letters

select upper('sql PraACtice') as upper_name
select lower('SQL Practice') as lower_name

select customer_name, upper(customer_name) as name_upper
from onlinne_orders 

select product_name, lower(product_name) as name_lower 
from onlinne_orders

--Show employee name in uppercase and email in lowercase
select upper(customer_name) as customer_name,
lower (product_name) as product_name
from onlinne_orders

--Find employee named “rahul” (even if stored as Rahul / RAHUL)

select * from onlinne_orders
where lower(customer_name)='rahul';

--REPLACE FUNCTIONS--
-- REPLACE() finds a word/character in text and replaces it with another one.

replace (column_name, 'old_text','new_text')

--Replace Delivered → Shipped (SELECT only)
select order_id,
customer_name,
replace (order_status,'delivered','shipped') as updated_status
from onlinne_orders;

--Replacing Laptop as PC
select order_id,
customer_name,
replace(product_name,'laptop','PC') as updated_products 
from onlinne_orders;

--Replace Banglore - Bengaluru
SELECT
  customer_name,
  REPLACE(city, 'Bangalore', 'Bengaluru') AS updated_city
FROM onlinne_orders;

-- Replace Mobile → Smartphone
select customer_name,
order_id,
replace(product_name,'Mobile','Smartphone')
from onlinne_orders

--Remove word Cancelled from status
select customer_name,
order_id,
replace(order_status,'cancelled',' ') acleaned_statuss 
from onlinne_orders

--Update permanently (be careful)
update onlinne_orders
set order_status = replace(order_status,'pending','In progress')

--Important Notes
--SELECT + REPLACE() → temporary result
--UPDATE + REPLACE() → permanent change

--TRIM LTRIM RTRIM--
-- TRIM()- Removes spaces from both sides

select 
trim(customer_name) as clean_name
from onlinne_orders

--LTRIM() – remove spaces from left only
select 
Ltrim(customer_name) as left_trimmed_name
from onlinne_orders

--RTRIM() – remove spaces from right only
select
Rtrim(customer_name) as right_trimmed_name
from onlinne_orders

--CONCATENATION-
--Concatenation = joining multiple text values into one sentence.

select
concat (customer_name,  'ordered'  ,product_name) as order_info
from onlinne_orders

select
concat (customer_name,'ordered',product_name,'from',city)
as full_order_details from onlinne_orders

SELECT
  CONCAT(
    'Order ', order_id,
    ': ',
    customer_name,
    ' - ',
    product_name,
    ' (',
    order_status,
    ')'
  ) AS order_summary
FROM onlinne_orders;


--SUBSTRINGS--
--SUBSTRING() extracts part of a text.

--Extract first 3 letters of customer name.
select
customer_name,
substring(customer_name,1,3) as short_name
from onlinne_orders;

--Extract first 3 letters of product_name
select
product_name,
substring(product_name,1,3) as short_name
from onlinne_orders

--Extract last 4 letters of the city
SELECT
  city,
  SUBSTRING(city, LEN(city) - 3, 4) AS city_end
FROM onlinne_orders;

--Extract word from order_status
select
order_status,
substring(order_status,1,3) as status_code
from onlinne_orders

--Real-life use (Create order code)
select
concat(
substring(customer_name,1,2),'-',
substring(product_name,1,2),'-',
order_id) as order_code from onlinne_orders

--String Aggregation--
--List all products in one row

select 
string_agg(product_name,',') as all_products
from onlinne_orders;

--List products city-wise
SELECT
  city,
  STRING_AGG(product_name, ', ') AS products_in_city
FROM onlinne_orders
GROUP BY city;

--List customer names by order_status
select order_Status,
string_agg(customer_name,',') as customers
from onlinne_orders
group by order_Status;
