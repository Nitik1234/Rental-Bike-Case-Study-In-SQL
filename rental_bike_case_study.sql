use bike_rental;
select * from bike as  b;
select * from customer as c ;
select * from membership as m;
select * from membership_type;
select * from rental;
-- Display the category name and the number of bikes the shop owns in 
-- each category
select category , count(model) as number_of_bike  from bike group by category ;
select category , count(*) as number_of_bike  from bike group by category  having number_of_bike>2;
--  Emily needs a list of customer names with the total number of 
-- memberships purchased by each
select c.name,count(m.membership_type_id) as membership_count
from customer as c 
left join
membership as m 
on c.id = m.customer_id group by c.name, c.id order by membership_count desc;
-- Emily is working on a special offer for the winter months. Can you help her 
-- prepare a list of new rental prices 
select id ,category,price_per_hour as old_price_per_hour,
case 
when category='electric' then round(price_per_hour*90/100,2)
when category='mountain bike' then round(price_per_hour*80/100,2)
else round(price_per_hour * 50/100,2)
end as new_price_per_hour,
 price_per_day as old_price_per_day,
 case
 when category='electric' then round(price_per_day*80/100,2)
when category='mountain bike' then round(price_per_day*50/100,2)
else round(price_per_hour * 50/100,2)
end as new_price_per_day
 from bike;
-- Emily is looking for counts of the rented bikes and of the available bikes in 
-- each category.
select category,sum(
case when status = 'available' then 1 else 0 end) as available_bikes,
sum(
case when status = 'rented' then 1 else 0 end) as rented_bikes
from bike group by category;
select * from bike;
--  Emily is preparing a sales report. She needs to know the total revenue 
-- from rentals by month, the total by year, and the all-time across all the 
-- years
select  year(start_timestamp) as yearr, 
monthname(start_timestamp) as month_name,sum(total_paid) as amount
from rental group by year(start_timestamp),monthname(start_timestamp)
order by yearr,month_name;
select * from membership;
select * from membership_type;

-- question 6  
select year(m.start_date) as Year,
month(m.start_date) as Month,mt.name as membership_name,
sum(m.total_paid) as revenue
from membership as  m
inner join 
membership_type as mt on m.membership_type_id = mt.id 
group by year(m.start_date) , month(m.start_date),mt.name;
-- question 
select * from bike;
select * from rental;
CREATE TEMPORARY TABLE rental_category AS
SELECT
    c.id,
    CASE
        WHEN COUNT(r.bike_id) > 10 THEN 'more than 10'
        WHEN COUNT(r.bike_id) BETWEEN 5 AND 10 THEN 'between 5 to 10'
        ELSE 'fewer than 5'
    END AS rental_category
FROM customer c
LEFT JOIN rental r
    ON c.id = r.customer_id
GROUP BY c.id;
SELECT
    rental_category,
    COUNT(*) AS no_of_customers
FROM rental_category
GROUP BY rental_category;






