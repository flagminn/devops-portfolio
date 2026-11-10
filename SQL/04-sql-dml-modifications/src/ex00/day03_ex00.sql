WITH 
    p AS (
        SELECT * FROM person 
        WHERE name = 'Kate'
    ),
    pv AS (
        SELECT person_visits.pizzeria_id, person_visits.visit_date 
        FROM person_visits
        JOIN  p ON p.id = person_visits.person_id
    ),
    m AS (
        SELECT menu.pizza_name, menu.price, menu.pizzeria_id, pv.visit_date 
        FROM menu 
        JOIN pv ON menu.pizzeria_id = pv.pizzeria_id
        WHERE price BETWEEN 800 AND 1000
    )
SELECT pizza_name,
price,
piz.name AS pizzeria_name,
visit_date
FROM m
JOIN pizzeria piz ON piz.id = m.pizzeria_id
ORDER BY 1, 2, 3;
