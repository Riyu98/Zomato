create database zomato;

use zomato;

-- 1) Help Zomato in identifying the cities with poor Restaurant ratings

select city,round(avg(rating),1) as poor_ratings from zomatoapp
group by city
order by poor_ratings asc
limit 10;

-- 2) Mr.roy is looking for a restaurant in kolkata which provides online delivery. Help him choose the best restaurant

select res_identify,city,has_online_delivery,rating from zomatoapp
where city like "kolkata" and has_online_delivery like "yes" and rating >4.5
order by rating desc;

-- 3) Help Peter in finding the best rated Restraunt for Pizza in New Delhi.

select res_identify,city,rating from zomatoapp
where city like "New delhi" and cuisines like "Pizza"
order by 3 desc
limit 1;

-- 4) Enlist most affordable and highly rated restaurants city wise.

Select Res_identify,price_range,city,rating
from zomatoapp
where Price_range between 1 and 5 And Rating > 4.5
order by 3,4 desc;

-- 5) Help Zomato in identifying the restaurants with poor offline services

select res_identify,has_table_booking,has_online_delivery,rating from zomatoapp
where has_table_booking like "yes" and has_online_delivery like "no" and rating between 1 and 2;

/* 6) Help zomato in identifying those cities which have atleast 3 restaurants with ratings >= 4.9
  In case there are two cities with the same result, sort them in alphabetical order.*/
  
select city, count(restaurantid) as no_of_restaurants from zomatoapp
where rating >=4.9
group by city
having no_of_restaurants >=3
order by city asc;

-- 7) What are the top 5 countries with most restaurants linked with Zomato?

select ct.country,ct.countrycode,count(za.restaurantid) as no_of_linked_restaurant
from countrytable as ct inner join zomatoapp as za on ct.countrycode=za.countrycode
group by ct.country,ct.countrycode
order by no_of_linked_restaurant desc
limit 5;

-- 8) What is the average cost for two across all Zomato listed restaurants?

select Average_cost_for_two, count(res_identify) as count from zomatoapp
group by Average_cost_for_two
order by count desc;

/* 9) Group the restaurants basis the average cost for two into: 
Luxurious Expensive, Very Expensive, Expensive, High, Medium High, Average. 
Then, find the number of restaurants in each category. */

select count(restaurantID) as no_of_restaurant,
case
when Average_cost_for_two >= 50000 then "luxurious_expensive"
when Average_cost_for_two between 10000 and 49999 then "very_expensive"
when Average_cost_for_two between 5000 and 9999 then "Expensive"
when Average_cost_for_two between 1000 and 4999 then "high"
when Average_cost_for_two between 500 and 999 then "medium_high"
else "average"
end as category
from zomatoapp
group by 
case
when Average_cost_for_two >= 50000 then "luxurious_expensive"
when Average_cost_for_two between 10000 and 49999 then "very_expensive"
when Average_cost_for_two between 5000 and 9999 then "Expensive"
when Average_cost_for_two between 1000 and 4999 then "high"
when Average_cost_for_two between 500 and 999 then "medium_high"
else "average"
end
order by no_of_restaurant desc;

-- 10) List the two top 5 restaurants with highest rating with maximum votes.

select res_identify,votes,rating from zomatoapp
order by rating desc, votes desc
limit 5;
















