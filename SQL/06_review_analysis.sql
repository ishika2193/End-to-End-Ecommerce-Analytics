/*
=========================================================
Review Analysis
=========================================================
*/

#-- What is the average review score?
select round(avg(review_score),2) as Average_score from olist_order_reviews;
=========================================================
#-- What is the distribution of the review score?
select count(*) as Total_reviews ,review_score from olist_order_reviews group by review_score order by review_score;
=========================================================
#-- Which are the top 10 lowest rated categories?
select p.product_category_name, round(avg(r.review_score),2) as Review_score,
count(r.review_id) as Count_Reviews
from olist_order_items_dataset d
join olist_order_reviews r
on d.order_id=r.order_id
join olist_products p
on p.product_id=d.product_id
group by p.product_category_name
having count(r.review_id)>=20
order by review_score asc limit 10;
=========================================================
#-- Which are the top 5 highest rated categories?
select p.product_category_name, round(avg(r.review_score),2) as Review_score,
count(r.review_id) as Count_Reviews
from olist_order_items_dataset d
join olist_order_reviews r
on d.order_id=r.order_id
join olist_products p
on p.product_id=d.product_id
group by p.product_category_name
having count(r.review_id)>=20
order by review_score desc limit 5;
=========================================================
#-- Do customers give lower ratings when deliveries take longer?
SELECT
    CASE
        WHEN o.order_delivered_customer_date < o.order_estimated_delivery_date THEN 'Early'
        WHEN o.order_delivered_customer_date = o.order_estimated_delivery_date THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(*) AS total_orders
FROM olist_orders o
JOIN olist_order_reviews r
ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;
