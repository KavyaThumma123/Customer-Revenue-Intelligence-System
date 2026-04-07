use salesDB;
create table sales(
		order_id int,
		customer varchar(50),
		region varchar(50),
		product varchar(50),
		amount int,
		order_date date
);
Insert into sales values
(101, 'A', 'Hyderabad', 'Laptop', 30000, '2024-01-01'),
(102, 'B', 'Mumbai', 'Mobile', 20000, '2024-01-02'),
(103, 'A', 'Hyderabad', 'Tablet', 15000, '2024-01-03'),
(104, 'C', 'Bangalore', 'Laptop', 40000, '2024-01-04'),
(105, 'B', 'Mumbai', 'Laptop', 35000, '2024-01-05'),
(106, 'D', 'Hyderabad', 'Mobile', 18000, '2024-01-06'),
(107, 'E', 'Bangalore', 'Tablet', 22000, '2024-01-07'),
(108, 'A', 'Hyderabad', 'Laptop', 45000, '2024-01-08'),
(109, 'C', 'Bangalore', 'Mobile', 25000, '2024-01-09'),
(110, 'D', 'Mumbai', 'Laptop', 30000, '2024-01-10');
select*from sales;

#Total Revenue per customer
select customer, sum(amount) as total_sales
from sales 
Group BY customer;

#Top Customer
select Top 5 customer, sum(amount) as total_sales
from sales 
Group By customer
Order By total_Sales Desc;

#Contribution %
select customer, 
	sum(amount)*100.0/sum(sum(amount)) over() as contribution
from sales
group by customer;

#Region wise sales
select region, sum(amount) as total_Sales
from sales
group by region;

select region, product, total_sales 
from (
	select region, product, sum(amount) as total_sales,
	Row_Number() over(partition by region order by sum(amount) desc) as rnk
	from sales
	group by region, product
)t
where rnk=1;

SELECT customer,
       COUNT(order_id) AS purchase_frequency
FROM sales
GROUP BY customer;

SELECT customer,
       MAX(order_date) AS last_purchase
FROM sales
GROUP BY customer;