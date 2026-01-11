-- student name = Fatima Nawab -- 

USE DS13;
select * from orders;
select * from items;
select * from customers; 

 -- question no 1 ---
 -- customer who hve placed more than 4 orders --- 
 
 SELECT 
    c.first_name, 
    c.last_name, 
    c.phone_number
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.phone_number
HAVING COUNT(o.order_id) > 4
ORDER BY c.first_name;

-- notes: here I have Joined customers with orders to know which orders belong to which customer.
-- then Group by customer_id to count their orders , and then i used HAVING COUNT(order_id) > 4 to filter only regular customers.
-- did some sorting of results alphabetically by first_name


-- quesion no 2 ---
-- Orders shipped between 2022-07-15 and 2022-07-20 but issue occurred ---

    select c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    c.city,
    c.phone_number,
    o.order_id,
    o.order_date,
    i.item_name,
    i.item_type,
    i.item_price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN items i ON o.item_id = i.item_id
WHERE o.order_date BETWEEN '2022-07-15' AND '2022-07-20'
ORDER BY o.order_date ASC;

 -- notes: Joined orders with customers and items,
 -- filter dates using Between 
 -- sorting by order date 
 
 -- question no 3 ---
 -- You wish to see which categories of items are doing well on Fridays.---
 
 SELECT 
    i.item_type,
    COUNT(o.order_id) AS order_count
FROM orders o
JOIN items i ON o.item_id = i.item_id
WHERE DAYNAME(o.order_date) = 'Friday'
GROUP BY i.item_type;

-- notes: join orders and itmes 
-- filter using dayname 
-- grouped by item type 

-- question no 3  how much of each item_type is ordered on Fridays -- What is the most ordered item_type(s) on Fridays?

WITH friday_counts AS (
    SELECT 
        i.item_type,
        COUNT(o.order_id) AS order_count
    FROM orders o
    JOIN items i ON o.item_id = i.item_id
    WHERE DAYNAME(o.order_date) = 'Friday'
    GROUP BY i.item_type
)
SELECT item_type, order_count
FROM friday_counts
WHERE order_count = (SELECT MAX(order_count) FROM friday_counts);

-- notes: used sub querry to get max orders

-- question no 4 parta ---
-- rank days of the week according to your order traffic ---

SELECT order_day, total_orders, rank_position
FROM (
  SELECT order_day, total_orders,
         RANK() OVER (ORDER BY total_orders DESC) AS rank_position
  FROM (
    SELECT DAYNAME(order_date) AS order_day,
           COUNT(*) AS total_orders
    FROM orders
    GROUP BY DAYNAME(order_date)
  ) AS day_counts
) AS ranked_days;

-- question 4 partb ---
-- show only the top 2 ranked days.

SELECT order_day, total_orders, rank_position
FROM (
  SELECT order_day, total_orders,
         RANK() OVER (ORDER BY total_orders DESC) AS rank_position
  FROM (
    SELECT DAYNAME(order_date) AS order_day,
           COUNT(*) AS total_orders
    FROM orders
    GROUP BY DAYNAME(order_date)
  ) AS day_counts
) AS ranked_days
WHERE rank_position <= 2;



-- nots: applied rank and where filter 

 