#Temporary Tables: Allows you to create a table that allows you to create a query out of

#List of all your users and how many rentals they have
		# How much revenue was brought in by users with over 20 rentals

create temporary table rentals_per_customer 
SELECT 
	r.customer_id as customer_id, count(r.rental_id) as num_rentals,
	SUM(p.amount) as Revenue 
FROM 
	rental r, payment p
WHERE
	p.rental_id = r.rental_id
GROUP BY 
	1
;


SELECT
	rpc.num_rentals, sum(rpc.Revenue) as total_revenue, count(rpc.customer_id)
FROM
	rentals_per_customer rpc 

GROUP BY
	1
;



# Find the revenue by Actor or Actress, 
# Actors name, amount of revenue they produced 


create temporary table revenue_per_actor 
SELECT
	concat(a.first_name, " ", a.last_name) as Name, sum(p.amount) as Revenue
FROM
	payment p, rental r, inventory i, film_actor fa, actor a 
WHERE
	a.actor_id = fa.actor_id
	AND 
	fa.film_id = i.film_id
	AND 
	i.inventory_id = r.inventory_id
	AND 
	r.rental_id = p.rental_id 
GROUP BY
	1

;

SELECT
	rpa.Name, rpa.Revenue
FROM
	revenue_per_actors rpa
GROUP BY
1
;







