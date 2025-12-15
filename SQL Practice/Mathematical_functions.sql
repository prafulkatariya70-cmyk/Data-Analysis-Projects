--CEILING--
--Rounds a number up to the nearest integer

SELECT 
    order_id,
    CEILING(order_id / 2.0) AS ceil_value
FROM onlinne_orders;

--Orders per box (real-life logic)--
SELECT 
    COUNT(*) AS total_orders,
    CEILING(COUNT(*) / 2.0) AS boxes_required
FROM onlinne_orders;

--FLOOR()--
-- Rounds a number DOWN to the nearest integer

select order_id,
floor(order_id/2.0) as floor_value
from onlinne_orders;

--Assume 3 orders = 1 batch
select count(*) as total_orders,
floor(count(*)/3.0) as completed_batches
from onlinne_orders

--CEILING vs FLOOR (Side-by-Side)
select order_id,
ceiling(order_id/3.0)as ceil_result,
floor(order_id/3.0) as floor_result
from onlinne_orders;

--ROUND--
--It rounds a number to a given number of decimal places

select round(12.345443,2) as rounded_value;

ALTER TABLE onlinne_orders
ADD order_amount DECIMAL(10,2);

UPDATE onlinne_orders
SET order_amount = 55999.678
WHERE order_id = 1;

UPDATE onlinne_orders
SET order_amount = 23999.432
WHERE order_id = 2;

UPDATE onlinne_orders
SET order_amount = 2999.999
WHERE order_id = 3;

UPDATE onlinne_orders
SET order_amount = 1499.456
WHERE order_id = 4;

--Round order amount to 2 decimals
SELECT
    order_id,
    customer_name,
    order_amount,
    ROUND(order_amount, 2) AS rounded_amount
FROM onlinne_orders;

--Round only Delivered orders
SELECT
    customer_name,
    order_amount,
    ROUND(order_amount, 1) AS rounded_amount
FROM onlinne_orders
WHERE order_status = 'Delivered';

--Round order amount to whole number
SELECT
    order_id,
    ROUND(order_amount, 0) AS rounded_amount
FROM onlinne_orders;

--POWER()--
--Calculate square of order amount

SELECT
    order_id,
    order_amount,
    POWER(order_amount, 2) AS squared_amount
FROM onlinne_orders;

--Assume 5% tax for 2 years

SELECT
    order_id,
    order_amount,
    order_amount * POWER(1.05, 2) AS amount_after_tax
FROM onlinne_orders;

--POWER() with condition
SELECT
    customer_name,
    order_amount,
    CASE 
        WHEN order_status = 'Delivered'
        THEN order_amount * POWER(1.10, 1)
        ELSE order_amount
    END AS final_amount
FROM onlinne_orders;





