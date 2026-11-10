WITH 
    man AS (
        SELECT pizzeria.name AS pizzeria_name
        FROM person_order po
        JOIN menu m ON m.id = po.menu_id
        JOIN pizzeria ON pizzeria.id = m.pizzeria_id
        JOIN person 
        ON person.id = po.person_id AND person.gender = 'male'
    ),
    woman AS (
        SELECT pizzeria.name AS pizzeria_name
        FROM person_order po
        JOIN menu m ON m.id = po.menu_id
        JOIN pizzeria ON pizzeria.id = m.pizzeria_id
        JOIN person 
        ON person.id = po.person_id AND person.gender = 'female'
    )
(SELECT pizzeria_name
FROM man
EXCEPT
SELECT pizzeria_name
FROM woman)

UNION

(SELECT pizzeria_name
FROM woman
EXCEPT
SELECT pizzeria_name
FROM man)

ORDER BY pizzeria_name
