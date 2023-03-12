--What is Angie’s Berry Corner’s average daily sales volume?
select avg(amount) from transactions
--What is the best selling product?
SELECT p.id,
       p.name,
       sum(t.amount)
FROM transactions t
JOIN products p ON t.product_id = p.id::integer
GROUP BY p.id,
         p.name
ORDER BY SUM DESC
LIMIT 1

-- Top 5 Angie loyalty customer?
SELECT c.*,
       sum(t.amount)
FROM transactions t
JOIN loyalty_customers c ON t.customer_id = c.id::integer
GROUP BY c.id,
         c.first_name,
         c.last_name
ORDER BY SUM DESC
LIMIT 5

--What is the full name of their current staff?
SELECT concat(first_name, ' ', last_name) AS full_name
FROM employees
WHERE end_date IS NULL

-- What is the product that generate the least income and by much.
select p.id, p.name, sum(t.amount) from transactions t
join products p 
on t.product_id = p.id::integer
group by p.id, p.name
order by sum

--The organization want to ascertain the income realize from sales
select sum(amount) 
from transactions
--which customer spends the least and by how much?
SELECT c.*,
       sum(t.amount)
FROM transactions t
JOIN loyalty_customers c ON t.customer_id = c.id::integer
GROUP BY c.id,
         c.first_name,
         c.last_name
ORDER BY SUM
LIMIT 1;
--which of the employee spend the least time at angie.
select 
  (end_date - start_date) as number_of_days 
from 
  employees 
where 
  end_date is not null

--full name of current employees
SELECT concat(first_name,' ',last_name) as full_name, DATE_PART('day', end_date::timestamp - start_date::timestamp) AS number_of_days from employees
where end_date is not null;
-- When is Angie berrys busiest hour?
SELECT extract(HOUR
               FROM to_timestamp(paid_at, 'DD/MM/YYYY HH24:MI')) AS HOUR,
       count(paid_at)
FROM transactions
GROUP BY HOUR
ORDER BY COUNT DESC;
--What is the best selling day of the week?
SELECT to_char(to_timestamp(paid_at, 'DD/MM/YYYY'), 'Day') AS DAY,
       count(paid_at)
FROM transactions
GROUP BY DAY
ORDER BY COUNT DESC
--* Which month of the year does the organization makes the most sales
SELECT to_char(to_timestamp(paid_at, 'DD/MM/YYYY'), 'Month') AS MONTH,
       count(paid_at)
FROM transactions
GROUP BY MONTH
ORDER BY COUNT DESC