-- Advanced:
-- 1.Calculate the percentage contribution of each pizza type to total revenue.
select pizza_types.category ,round((sum(order_details.quantity * pizzas.price)/ (SELECT  ROUND(SUM(QUANTITY * PRICE),2) AS  
TOTAL_SALES FROM ORDER_DETAILS JOIN PIZZAS ON PIZZAS.PIZZA_ID=ORDER_DETAILS.PIZZA_ID))*100,2) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details 
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by revenue desc;

-- 2. Analyze the cumulative revenue generated over time.
-- 200 200
-- 300 500
-- 450 950
-- 250 1200

select order_date,sum(revenue) over(order by order_date) as cum_revenue from
(select orders.order_date, sum(order_details.quantity * pizzas.price) as revenue from order_details
join  pizzas on order_details.pizza_id=pizzas.pizza_id 
JOIN orders on orders.order_id=order_details.order_id
group by orders.order_date) as sales;


-- 3.Determine the top 3 most ordered pizza types based on revenue for each pizza category.

