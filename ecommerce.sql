create database portfolio;

use portfolio;

create table ecommerce(
Order_ID varchar(15),
Customer_ID varchar(15),
Date varchar(15),
Age int not null,
Gender char(10),
City char(15),
Product_Category varchar(20),
Unit_Price decimal(7,2) not null,
Quantity int,
Discount_Amount decimal(5,2),
Total_Amount decimal(7,2),
Payment_Method varchar(20),
Device_Type varchar(10),
Session_Duration_Minutes int,
Pages_viewed int,
Is_Returning_Customer boolean,
Delivery_Time_Days int,
Customer_Rating int
);

-- data exploration
-- no.of rows
select count(*) from ecommerce;
-- sample
select * from ecommerce
limit 10;
-- null values
select * from ecommerce where Customer_ID is null;
-- different product categories
select distinct Product_Category
from ecommerce
order by Product_Category;

-- total revenue
select sum(Total_Amount) as overall_revenue
from ecommerce;
-- total revenue for each category
select Product_Category, sum(Total_Amount)
from ecommerce
group by Product_Category
order by sum(Total_Amount) desc;
-- top 10 customers(by spending)
select Customer_ID, sum(Total_Amount) as total
from ecommerce
group by Customer_ID
order by total desc
limit 10;
-- average value of an order
select avg(Total_Amount) as avg_value from ecommerce;
-- does returning customers spend more than new customers?
select Is_Returning_Customer ,
count(distinct Customer_ID) as customers,
avg(Total_Amount) as avg,
sum(Total_Amount) as total
from ecommerce
group by Is_Returning_Customer;
-- total by payment method
select Payment_Method,
count( distinct Customer_ID) as customers,
sum(Total_Amount) as total
from ecommerce
group by Payment_Method
order by total desc;
-- which cities do high sale
select City,
count(distinct Customer_ID) as num_customers, 
sum(Total_Amount) as total
from ecommerce
group by City
order by total desc;
-- do customer gives low ratings when delivery takes longer?
select Delivery_Time_Days,
count( distinct Customer_ID) as customers,
avg(Customer_Rating) as avg_rating
from ecommerce
group by Delivery_Time_Days
order by Delivery_Time_Days;
-- orders generated more than 5000
select Order_ID,
Product_Category,
Customer_ID,
Total_Amount
from ecommerce
where Total_Amount>5000
order by Total_Amount desc;
-- customers who spend more time on website buy more?
SELECT
    Device_Type,
    AVG(Session_Duration_Minutes) AS avg_session_time,
    AVG(Pages_Viewed) AS avg_pages_viewed,
    AVG(Total_Amount) AS avg_order_value
FROM ecommerce
GROUP BY Device_Type
ORDER BY avg_order_value DESC;