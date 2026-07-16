/*
=========================================================
Customer Analysis
=========================================================
*/


-- How many total customers are there?
select count(8) as total_count from olist_customers;

=========================================================
-- How many unique customers are there
select count(distinct customer_unique_id) as Count_customers from olist_customers;

=========================================================
-- Which state has the most customers?
select customer_state, count(distinct customer_unique_id) as total_customers
from olist_customers
group by customer_state
order by total_customers desc limit 1;

=========================================================
-- Who are the Top 5 Customers by Spending in Each State?
SELECT *
FROM (
    SELECT
        c.customer_state,
        c.customer_unique_id,
        ROUND(SUM(oi.price), 2) AS total_spent,
        DENSE_RANK() OVER (
            PARTITION BY c.customer_state
            ORDER BY SUM(oi.price) DESC
        ) AS customer_rank
    FROM olist_customers c
    JOIN olist_orders o
        ON c.customer_id = o.customer_id
    JOIN olist_order_items_dataset oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_state, c.customer_unique_id
) AS ranked_customers
WHERE customer_rank <= 5
ORDER BY customer_state, customer_rank;

=========================================================
-- Show top 10 customers by spendings
select c.customer_id, sum(p.payment_value) As Total_payment
from olist_customers c
join olist_orders o
on c.customer_id=o.customer_id
join olist_order_payments p
on p.order_id=o.order_id
group by c.customer_id
order by Total_payment desc limit 10 ;

=========================================================
-- Who all are the repeated customers with multiple orders
select c.customer_unique_id, count(o.order_id) as Total_orders
from olist_customers c
join olist_orders o
on c.customer_id=o.customer_id
group by c.customer_unique_id having total_orders>1;









