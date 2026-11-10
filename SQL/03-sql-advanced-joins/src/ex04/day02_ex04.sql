SELECT m.pizza_name,
p.name AS pizzeria_name,
m.price
FROM 
    (SELECT * FROM menu WHERE pizza_name = 'mushroom pizza' OR pizza_name = 'pepperoni pizza') AS m
JOIN pizzeria p ON p.id = m.pizzeria_id
ORDER BY pizza_name,  pizzeria_name;