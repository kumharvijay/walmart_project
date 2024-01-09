-- This project aims to explore the Walmart Sales data to understand top performing branches
-- and products, sales trend of of different products, customer behaviour. 
-- The aims is to study how sales strategies can be improved and optimized
-- will perform 1.Product Analysis 2. Sales Analysis 3. customer analysis--
SELECT * FROM walmart_project.`walmart.csv`;

-------------------------------------------------------------------------------------------------------------------------------------------------
-- ------- Feature engineering-------
SELECT 
    time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE "Evening"
	END) AS time_of_day
FROM walmart_project.`walmart.csv`;
Alter table walmart_project.`walmart.csv` add column time_of_day varchar(20);
select*from walmart_project.`walmart.csv`;
-- setup the data in time_of_day--
update walmart_project.`walmart.csv`
Set time_of_day= (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
		WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		ELSE "Evening"
	END
);

UPDATE walmart_project.`walmart.csv`
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);
select*from walmart_project.`walmart.csv`;

-- -------------------------------
-- ----- day_name-----------------
 select date from walmart_project.`walmart.csv`;
select date,
       DAYNAME(date)
from walmart_project.`walmart.csv`;
alter table walmart_project.`walmart.csv` add column  day_name varchar(20);
update walmart_project.`walmart.csv`
set day_name= DAYNAME(date);

select*from walmart_project.`walmart.csv`;

-- --------------------------------------------------
-- --------month_name--------------------------------
select date,
      MONTHNAME(date)
from walmart_project.`walmart.csv`;
-- add month_name-----
alter table walmart_project.`walmart.csv` add column month_name varchar(20);
-- update data in column---
update walmart_project.`walmart.csv`
set month_name= MONTHNAME(date);
select*from walmart_project.`walmart.csv`;

------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------
-- ----------- generic------------
-- how many unique citis does data have--
select distinct City from walmart_project.`walmart.csv`;
select distinct Branch from walmart_project.`walmart.csv`;
select distinct city, branch from walmart_project.`walmart.csv`;

-- how many product unique line  does data have?--

SELECT
	count(DISTINCT product_line)
FROM walmart_project.`walmart.csv`;
select*from walmart_project.`walmart.csv`;

-- most comman payment method--
select payment, count(payment) as cnt from walmart_project.`walmart.csv` group by payment 
order by cnt desc;

-- most  selling product line--
select product_line, count(product_line) as pl from walmart_project.`walmart.csv` group by Product_line
order by pl desc;

-- total revenue by month--
select month_name, sum(total) as total_revenue from walmart_project.`walmart.csv` 
group by month_name
order by total_revenue desc;

-- what month has the largest cogs--
select month_name, sum(cogs) as cog from walmart_project.`walmart.csv`
group by month_name
order by cog desc;

-- what product line had the largest revenue--
select product_line, sum(total) as revenue from walmart_project.`walmart.csv`
group by product_line
order by revenue desc;
-- city with the largest revenue--
select branch,city, sum(total) as revenue from walmart_project.`walmart.csv`
group by city,branch
order by revenue desc;
-- which branch sold more products than avg products--
select branch, sum(quantity) as qt
from walmart_project.`walmart.csv`
group by branch
having sum(quantity)> (select avg(quantity) from walmart_project.`walmart.csv`);

-- what is the most product line by gender--
select gender, product_line, count(gender) as cnt from walmart_project.`walmart.csv`
group by gender, product_line
order by cnt desc;
-- what is the avg rating of each product line--
select product_line, avg(rating) as rating from walmart_project.`walmart.csv`
group by Product_line;
-- or--
select product_line, round(avg(rating),2) as rating from walmart_project.`walmart.csv`
group by Product_line;


-- --------------------------------------------------------------------
-- -----------------------SALES----------------------------------------
-- number of sales made in each time of the day per weekday--
select time_of_day, count(*) as total_sales
from walmart_project.`walmart.csv`
where day_name="tuesday"
group by time_of_day
order by total_sales desc;

-- which of the customer types bring the most revenue?--
select customer_type, sum(total) as total_revenue
from walmart_project.`walmart.csv`
group by Customer_type
order by total_revenue desc;
-- which city has the largest tax percent/ vat(value added tex)--
select city, avg(Tax) as tax from walmart_project.`walmart.csv`
group by city
order by tax desc;

-- ---------------------------------------------------------------
-- -----------------customer--------------------------------------
-- how many unique customer type does the data have--
select distinct customer_type from walmart_project.`walmart.csv`;
-- How many unique payment methods does the data have?--
select count(distinct payment) from walmart_project.`walmart.csv`;
-- Which customer type buys the most?--
select customer_type, count(*) as cnt from walmart_project.`walmart.csv`
group by customer_type;
-- What is the gender of most of the customers?--
select gender,count(*) from walmart_project.`walmart.csv` group by gender; 
-- What is the gender distribution per branch?--
select 
    gender, count(*) as cnt
from walmart_project.`walmart.csv`
where Branch='B'
group by gender;
-- Which time of the day do customers give most ratings?--
SELECT 
    time_of_day, AVG(rating) AS rating
FROM walmart_project.`walmart.csv`
WHERE branch = 'B'
GROUP BY time_of_day
ORDER BY rating DESC;
-- Which day of the week has the best avg ratings?--
select*from walmart_project.`walmart.csv`;
select day_name, avg(rating) as rating
from walmart_project.`walmart.csv`
group by day_name
order by rating desc;
-- Which day of the week has the best average ratings per branch?--
select day_name, avg(rating) as rating
from walmart_project.`walmart.csv`
where branch ='B'
group by day_name
order by rating desc;

-- ---------------------------------------------------------------------------------------------
-- ---------------------------------------END---------------------------------------------------
-- ---------------------------------------------------------------------------------------------








