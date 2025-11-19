CREATE DATABASE DOMINOS;
SELECT *FROM DOMINOS.PIZZAS;
SELECT *FROM DOMINOS.PIZZA_TYPES;

CREATE TABLE ORDERS(
ORDER_ID INT PRIMARY KEY NOT NULL,
ORDER_DATE DATE NOT NULL,
ORDER_TIME TIME NOT NULL
);
SELECT*FROM DOMINOS.ORDERS;

CREATE TABLE ORDER_DETAILS (
    ORDER_DETAILS_ID INT PRIMARY KEY NOT NULL,
    ORDER_ID INT NOT NULL,
    PIZZA_ID TEXT NOT NULL,
    QUANTITY INT NOT NULL
);
SELECT*FROM ORDER_DETAILS;


-- Retrieve the total number of orders placed.
SELECT COUNT(ORDER_ID)
FROM ORDERS;

-- Calculate the total revenue generated from pizza sales.
SELECT
round(sum(order_details.quantity * pizzas.price),2) as total_sales
from order_details join pizzas
on pizzas.pizza_id =  order_details.PIZZA_ID;


-- Identify the highest-priced pizza.

select pizza_types.name,pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc
limit 1;

-- Identify the most common pizza size ordered.

select pizzas.size, count(order_details.ORDER_DETAILS_ID) as order_count
from pizzas join order_details
on pizzas.PIZZA_ID = order_details.PIZZA_ID
group by pizzas.size
order by order_count desc;

-- List the top 5 most ordered pizza types along with their quantities.

select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.PIZZA_ID = pizzas.pizza_id
group by pizza_types.name
order by quantity desc
limit 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category,
sum(order_details.QUANTITY) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id= pizzas.pizza_type_id
join order_details
on order_details.PIZZA_ID =pizzas.pizza_id
group by pizza_types.category order by QUANTITY desc;


-- Determine the distribution of orders by hour of the day.

select hour(order_time),count(order_id) from orders
group by hour(ORDER_TIME);

-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    pizza_types.category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

select orders.ORDER_DATE, sum(order_details.QUANTITY)
from orders join order_details
on orders.ORDER_ID = orders.ORDER_ID
group by orders.ORDER_DATE;









