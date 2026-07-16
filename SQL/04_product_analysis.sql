/*
=========================================================
Product Analysis
=========================================================
*/

#-- Number of products
select count(distinct customer_unique_id) as total_customers from olist_customers;
=========================================================
#-- Number of categories
alter table product_category_name_translation rename column `ï»¿product_category_name` to product_category_name;
select count(distinct product_category_name) from product_category_name_translation;
=========================================================
#--Average product weight?
select avg(product_weight_g) as Average_product_weight from olist_products;
=========================================================
#-- Largest product
select product_id, product_category_name,
product_weight_g, product_length_cm, product_height_cm,
(product_weight_g*product_length_cm*product_height_cm) as volume
from olist_products
order by volume desc limit 1;
=========================================================
#-- smallest product
select product_id, product_category_name,
product_weight_g, product_length_cm, product_height_cm,
(product_weight_g*product_length_cm*product_height_cm) as volume
from olist_products
where product_weight_g is not null
and product_length_cm is not null
and product_height_cm is not null
order by volume asc limit 1;
=========================================================
#-- What is the highest freight cost charged?
SELECT MAX(freight_value)
FROM olist_order_items_dataset;
=========================================================
#-- What is the average freight cost?
select avg(freight_value) as Average_freight from olist_order_items_dataset;
=========================================================
#-- Top 20 Most Expensive Products
select product_id, price from olist_order_items_dataset order by price desc limit 20;
