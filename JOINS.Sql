CREATE TABLE Customerss (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orderss (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(50),
    Amount INT,
    OrderDate DATE
);

CREATE TABLE Paymentss (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentMode VARCHAR(20),
    Status VARCHAR(20)
);

INSERT INTO Customerss VALUES
(1, 'Alice', 'Mumbai'),
(2, 'Bob', 'Pune'),
(3, 'Charlie', 'Delhi'),
(4, 'Diana', 'Mumbai'),
(5, 'Eve', 'Chennai');

INSERT INTO Orderss VALUES
(101, 1, 'Laptop', 80000, '2024-11-01'),
(102, 2, 'Chair', 3000, '2024-11-02'),
(103, 1, 'Phone', 60000, '2024-11-03'),
(104, 4, 'Tablet', 25000, '2024-11-04'),
(105, 6, 'Camera', 45000, '2024-11-05');  -- Customer 6 does NOT exist

INSERT INTO Paymentss VALUES
(1, 101, 'UPI', 'Success'),
(2, 102, 'Card', 'Failed'),
(3, 103, 'UPI', 'Success'),
(4, 200, 'Cash', 'Pending');  -- Order 200 does NOT exist

select * from Customerss
select * from Orderss
select * from Paymentss

--INNER JOINS
--Show customer name, product, and amount for all successful payments

SELECT c.CustomerName, o.Product, o.Amount, p.Status
FROM Customerss c
INNER JOIN Orderss o ON c.CustomerID = o.CustomerID
INNER JOIN Paymentss p ON o.OrderID = p.OrderID
WHERE p.Status = 'Success';

--Get all orders from customer names
select o.orderID,
c.customerName,
o.product,
o.amount
from Orderss o 
inner join customerss c
on o.customerid=c.CustomerID

--Get customer name, city, product, and payment mode
select
c.customername,
c.city,
o.product,
p.paymentmode,
p.status
from customerss c
inner join orderss o
on c.customerid=o.CustomerID
inner join Paymentss p
on o.orderid = p.OrderID

-- Find all successful payments with customer names
select
c.customername,
o.product,
p.paymentmode,
p.status
from customerss c
inner join orderss o
on c.customerid=o.CustomerID
inner join Paymentss p
on o.OrderID = p.OrderID
where p.status='success'

--List customers who placed orders above ₹30,000
select 
c.customername,
o.product,
o.amount
from customerss c
inner join Orderss o
on c.CustomerID = o.customerid
where o.amount>30000;

--Show all successful payments with customer names
select
c.customerid,
c.customername,
o.product,
o.amount,
p.status
from customerss c
inner join orderss o
on c.customerid=o.customerid
inner join Paymentss p
on o.OrderID=p.orderid
where p.Status='Success'

--Show customers whose orders have a failed or pending payment

select 
c.customername,
o.product,
p.status
from Customerss c
inner join orderss o
on c.customerid = o.CustomerID
inner join paymentss p
on o.orderid=p.orderid
where p.Status in ('failed','pending');

   --LEFT JOINS--

 --Show all customers and their orders (if any)
 select 
 c.customername,
 o.product
 from customerss c
 left join orderss o
 on c.customerid=o.CustomerID

 -- Find customers who did NOT place any order
 select
 c.CustomerName
 from customerss c
 left join orderss o
 on c.CustomerID = o.CustomerID
 where o.OrderDate is null;

 --Show customers with payment info (even if no payment exists)
 
 select
 c.customername,
 p.status
 from customerss c
 left join Orderss o
 on c.customerid=o.CustomerID
 left join Paymentss p
 on o.orderid = p.OrderID

 --Show all customers and total amount they spent

 select
 c.customername,
 sum(o.amount) as totalspent
 from customerss c
 left join orderss o
 on c.customerid = o.CustomerID
 group by c.customername;

 -- Show all customers and their latest order date
 SELECT
    c.CustomerName,
    MAX(o.OrderDate) AS LastOrderDate
FROM Customerss c
LEFT JOIN Orderss o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

--Show customers with their order + payment info
select
c.customername,
o.product,
o.amount,
p.paymentmode
from customerss c
left  join orderss o
on c.CustomerID = o.CustomerID
left join Paymentss p
on o.orderid = p.OrderID

--RIGHT JOIN --

--Get all orders, even if the customer is missing
select
o.orderid,
o.product,
o.amount,
c.customername,
c.city
from customerss c
right join orderss o
on c.customerid = o.CustomerID

-- Show orders placed in November
select
o.orderid,
o.product,
o.orderdate,
c.customername
from customerss c
right join orderss o
on c.customerid = o.CustomerID
where month(o.orderdate)=11;

--Find orders whose customer details are missing
select
o.orderid,
o.product,
o.amount,
c.customername
from customerss c
right join orderss o
on c.Customerid = o.CustomerID
where customername = 'Null';

-- Show all orders with customer city

Select
o.orderid,
o.product,
o.amount,
c.customername,
c.city
from customerss c
right join orderss o
on c.CustomerID = o.CustomerID

--Find the total amount spent on each order

select
o.orderid,
o.product,
o.amount as total_amount,
c.customername
from customerss c
right join orderss o
on c.customerid = o.CustomerID

-- List product names and customer names
select 
o.product,
c.customername
from Customerss c
right join orderss o
on c.customerid = o.CustomerID

--Show each order along with the customer’s city, but only for orders above ₹50,000.

select
o.orderid,
o.product,
o.amount,
c.customername,
c.City
from Customerss c
right join orderss o
on c.CustomerID = o.CustomerID
where (o.Amount)>50000

-- Count how many orders each customer has

select
c.customername,
count(o.orderid) as total_orders
from customerss c
right join orderss o
on c.CustomerID = o.CustomerID
group by c.customername;

-- Show latest order date for each customer

select
max (o.orderdate) as Latest_order_date,
c.customername
from Customerss c
right join orderss o
on c.customerid = o.CustomerID
group by c.CustomerName

-- FULL OUTER JOIN --

--Show all customers and their orders
select
c.customername,
o.orderid,
o.product,
o.amount
from customerss c
full outer join orderss o
on c.CustomerID=o.CustomerID

-- Show customers without orders + orders without customers
select *
from Customerss c
full outer join orderss o
on c.customerid = o.CustomerID
where c.CustomerID is null or o.orderid is null;

-- Show all cities with total order amount
select
c.city,
Sum(o.amount) as total_amount
from customerss c
full outer join orderss o
on c.customerid = o.customerid
group by c.city;

-- CROSS JOIN --

-- Create all customer-product combinations
select 
c.customername,
o.product
from customerss c
cross join orderss o
on c.customerid = o.customerid

--every customer with every payment mode
select
c.customername,
p.paymentmode
from Customerss c
cross join paymentss p;

--Count how many pairs cross join produces

select count(*) as total_pairs
from customerss c
cross join orderss o;






 










