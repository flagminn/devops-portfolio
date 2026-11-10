WITH 
da AS (
    SELECT * FROM person WHERE name = 'Denis' OR name = 'Anna'
),
oda AS (
    SELECT * FROM person_order po JOIN da ON po.person_id = da.id 
)
SELECT 
   m.pizza_name,
   piz.name AS pizzeria_name
FROM menu m
JOIN oda ON oda.menu_id = m.id
JOIN pizzeria piz ON m.pizzeria_id = piz.id
ORDER BY 1, 2;
