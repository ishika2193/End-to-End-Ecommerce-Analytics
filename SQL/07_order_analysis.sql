/*
=========================================================
Order Analysis
=========================================================
*/

--Total orders?
select count(distinct order_id) from olist_orders;
=========================================================
--delivered orders?
select count(order_id) from olist_orders where order_status="delivered";
=========================================================
-- cancelled orders?
select count(order_id) from olist_orders where order_status="canceled";
=========================================================
-- pending orders?
select count(order_id) from olist_orders where order_status NOT IN('delivered','invoiced') ;
=========================================================
-- How many many orders are there in every status? 
select order_status, count(distinct order_id) as total_orders from olist_orders
group by order_status 
order by total_orders desc;
=========================================================
-- Rank sellers based on the revenue they generated.
select seller_id, Total_price, row_number() over(order by Total_price desc) as Revenue_rank from(
select seller_id, round(sum(price),2) as Total_price
from olist_order_items_dataset 
group by seller_id) as seller_revenue;
