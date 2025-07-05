select * from [KMS Sql Case Study]

-- Solution to question 1. 
--Which product category had the highest sales?


select top 1
	product_category,
	sum(sales)
	from [KMS Sql Case Study]
	group by Product_Category

--solution to question 2. 
--What are the Top 3 and Bottom 3 regions in terms of sales?
SELECT top 3 
	Region as [bottom 3 region in terms of sales], SUM(Sales) AS TotalSales
	FROM [KMS Sql Case Study]
	GROUP BY Region
	ORDER BY TotalSales desc;

--solution to question 3. 
--What were the total sales of appliances in Ontario?
SELECT 
	SUM(Sales) AS Total_Sales_For_Ontario
	FROM [KMS Sql Case Study]
	WHERE Product_Sub_Category = 'Appliances'
	AND Province = 'Ontario';

--solution to question 4. 
--Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers

select distinct top 10
 customer_name,
	round(sum(sales),2) as total_sales
	from [KMS Sql Case Study]
	group by Customer_Name
	order by total_sales asc
	
--solution to question 5. 
--KMS incurred the most shipping cost using which shipping method?
select top 1
	Ship_Mode,
	round(sum(shipping_Cost),2) as TotalShipingCost
	from [KMS Sql Case Study]
	group by Ship_Mode
	order by TotalShipingCost desc

-- solution to question 6. 
--Who are the most valuable customers, and what products or services do they typically purchase?
SELECT 
	Customer_Name, 
	Product_Category,
	sum(sales) as totalsales
FROM [KMS Sql Case Study]
	WHERE Customer_Name = (
		SELECT TOP 1 Customer_Name
		FROM [KMS Sql Case Study]
		GROUP BY Customer_Name
		ORDER BY SUM(Sales) DESC
)
GROUP BY Product_Category, Customer_Name;

-- solution to question 7. 
--Which small business customer had the highest sales?
select top 1
	Customer_Name,
	sum(sales) as TotalSales
	from [KMS Sql Case Study]
	where customer_segment = 'small business'
	group by Customer_Name
	order by TotalSales desc;

--solution to question 8. 
--Which Corporate Customer placed the most number of orders in 2009 – 2012?

	SELECT top 1 
    Customer_Name,
	sum(Order_Quantity) as totalOrders
FROM [KMS Sql Case Study]
WHERE Customer_Segment= 'corporate' and Year(Order_Date) between '2009' and '2012'
    group by Customer_Name
    order by totalOrders desc
	
--Solution to Question 9. 
--Which consumer customer was the most profitable one?
select top 1
	Customer_Name,
	sum(Profit) as TotalProfit
from [KMS Sql Case Study]
	where Customer_Segment = 'Consumer'
	group by Customer_Name
	Order by TotalProfit Desc

--Solution to Question 10. 
--Which customer returned items, and what segment do they belong to?
select distinct
	[KMS Sql Case Study].Customer_Name,
	[KMS Sql Case Study].Customer_Segment,
	[Order_Status (1)].Status
	from [KMS Sql Case Study]
	inner join [Order_Status (1)] on [KMS Sql Case Study].Order_ID = [Order_Status (1)].Order_ID
	where [Order_Status (1)].Status = 'Returned'
	--group by Customer_Segment, Customer_Name

--Solution to Question 11. 
--If the delivery truck is the most economical but the slowest shipping method and Express Air is 
--the fastest but the most expensive one, do you think the company appropriately spent shipping costs 
--based on the Order Priority? Explain your answer

SELECT 
    Order_Priority, 
    Ship_Mode,
    COUNT(Order_ID) AS countOfOrder,
    SUM(sales - profit) AS estShippingCost,
    AVG(DATEDIFF(DAY, Order_Date, Ship_Date)) AS averageShipping
FROM 
    [KMS Sql Case Study] 
GROUP BY 
    Order_Priority, Ship_Mode
ORDER BY 
    Order_Priority, Ship_Mode    Desc;

	select * from [KMS Sql Case Study]