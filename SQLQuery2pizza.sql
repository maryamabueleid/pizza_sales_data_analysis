-- the table
select * from pizza_sales

-- total revenue
select sum(total_price) as total_revenue from pizza_sales

-- average order value
select sum(total_price) / count(distinct order_id) as average_order_value from pizza_sales

--total pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales

--total orders
select  count(distinct order_id) as total_orders from pizza_sales

--average pizza per order
select sum(quantity) /count(distinct order_id) as avg_pizza_per_order from pizza_sales        -- if we want it in decimal --select cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id) as decimal(10,2)) as avg_pizza_per_order from pizza_sales

--daily trend for orders / total orders of a period of time
select datename(dw,order_date) as order_day, count(distinct order_id) as total_orders from pizza_sales
group by datename(dw,order_date)

--hourly trend for orders
select datepart(hour,order_time) as order_hour ,count(distinct order_id) as total_orders from pizza_sales
group by datepart(hour,order_time)
order by datepart(hour,order_time)

--pizza sales pct per category
select pizza_category , sum(total_price) as total_sales,sum(total_price) *100 /(select sum(total_price) from pizza_sales) as '%'
from pizza_sales 
group by pizza_category

--filter pizza sales pct per category per month
select pizza_category , sum(total_price) as total_sales,sum(total_price) *100 /(select sum(total_price) from pizza_sales where month(order_date)=1) as '%'
from pizza_sales 
where month(order_date)=1
group by pizza_category

--pizza sales pct per size
select pizza_size ,sum(total_price) as total_sales ,sum(total_price) * 100 /(select sum(total_price)from pizza_sales ) as '%'
from pizza_sales
group by pizza_size

--pizza sales pct per size with specific order
select pizza_size ,sum(total_price) as total_sales ,sum(total_price) * 100 /(select sum(total_price)from pizza_sales ) as '%'
from pizza_sales
group by pizza_size
order by '%' desc  --or asc

--total pizza sold
select pizza_category , sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_category

--best sellers (top 5)
select top 5 pizza_name , sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by sum(quantity) desc

--best sellers (top 5) for specific month
select top 5 pizza_name , sum(quantity) as total_pizza_sold
from pizza_sales
where month(order_date) =1
group by pizza_name
order by sum(quantity) desc

--worst sellers( bottom 5)
select top 5 pizza_name , sum(quantity) as total_pizza_sold
from pizza_sales
group by pizza_name
order by sum(quantity) asc

