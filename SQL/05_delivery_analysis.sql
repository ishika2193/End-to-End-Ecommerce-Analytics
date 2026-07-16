/*
=========================================================
Delivery Analysis
=========================================================
*/

#-- What is the average time taken to deliver an order?
select round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),2) as Time 
from olist_orders where order_delivered_customer_date is not null;
=========================================================
#-- Show the orders that were delivered late
select order_id, round(datediff(order_delivered_customer_date,order_estimated_delivery_date),2) as Late_delivery
from olist_orders where order_delivered_customer_date is not null and order_delivered_customer_date>order_estimated_delivery_date;
=========================================================
#-- How many orders were delivered late?
select count(*) as Late_orders from olist_orders where order_delivered_customer_date>order_estimated_delivery_date;
=========================================================
#-- What is the delivery time in each state?
select c.customer_state, round(avg(datediff(o.order_delivered_customer_date,o.order_purchase_timestamp)),2) as Delivery_time
from olist_customers c
join olist_orders o
on c.customer_id=o.customer_id
where o.order_delivered_customer_date is not null
group by c.customer_state order by Delivery_time desc;
=========================================================
#-- What is the delivery time by seller?
select seller_id, round(avg(Delivery_days),2) as Avg_delivery_days from
(select distinct
d.seller_id, d.order_id, round(datediff(o.order_delivered_customer_date,o.order_purchase_timestamp),2) as Delivery_days
from olist_orders o
join olist_order_items_dataset d
on o.order_id=d.order_id
where o.order_delivered_customer_date is not null) as seller_orders
group by seller_id
order by Avg_delivery_days desc;
=========================================================
#-- How many orders are delivered before estimated date?
select count(order_id) as Total_orders from olist_orders where order_estimated_delivery_date>order_delivered_customer_date
and order_delivered_customer_date is not null;

