-- Intermediate:
-- 1.Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pizza_types.category,SUM(order_details.QUANTITY) AS QUANTITY FROM order_details
JOIN PIZZAS ON PIZZAS.PIZZA_ID=ORDER_DETAILS.PIZZA_ID
JOIN pizza_types ON pizza_types.pizza_type_id=PIZZAS.PIZZA_TYPE_ID group by pizza_types.CATEGORY ORDER BY QUANTITY DESC;

-- 2.Determine the distribution of orders by hour of the day.
SELECT HOUR(ORDER_TIME) AS HOUR,COUNT(ORDER_ID) FROM ORDERS GROUP BY HOUR ;

-- 3.Join relevant tables to find the category-wise distribution of pizzas.
SELECT CATEGORY,COUNT(NAME) FROM pizza_types GROUP BY CATEGORY;

-- 4.Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quanti),0) from
(select orders.order_date,sum(order_details.quantity) as quanti 
from orders join order_details
on orders.order_id =order_details.order_id
group by orders.order_date) as data;  -- every derived table must have its own alias


-- 5.Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name ,sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details 
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;
