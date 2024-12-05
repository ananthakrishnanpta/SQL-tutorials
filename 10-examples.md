```sql
use sakila;

-- Which customer spent the max amount of money in total? and what is the amount?

-- i) find the total amount spent by each customer -> solved using creating a view from the aggregate results

create view per_customer_tots as (select customer_id, sum(amount) as total
from payment
group by customer_id);

select * from per_customer_tots;
-- ii) find max of these per_customer_tots -> aggregate function

select max(total) from per_customer_tots;

-- iii) find the customer having maximum total spends -> filtering

select customer_id 
from per_customer_tots 
where total = (select max(total) from 
				per_customer_tots);
                
-- iv) find the customer's name -> join

select concat(c.first_name, " ", c.last_name) from
customer c
join 
(select customer_id 
from per_customer_tots 
where total = (select max(total) from 
				per_customer_tots)) t2 
               on c.customer_id = t2.customer_id ;

-- The same query can be stored inside a view to query the result whenever required.

create view star_customer as 
(select concat(c.first_name, " ", c.last_name) 
from customer c
	join 
		(select customer_id 
			from per_customer_tots 
			where total = (select max(total) from 
								(select customer_id, sum(amount) as total
								from payment 
								group by customer_id
								) t1
							)
		) t2 
	on c.customer_id = t2.customer_id );
    
    
    select * from star_customer;


```
