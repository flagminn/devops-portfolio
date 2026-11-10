WITH 
    man AS (
        SELECT pizzeria.name AS pizzeria_name
        FROM person_visits pv
        JOIN pizzeria ON pizzeria.id = pv.pizzeria_id
        JOIN person 
        ON person.id = pv.person_id AND person.gender = 'male'
    ),
    woman AS (
        SELECT pizzeria.name AS pizzeria_name
        FROM person_visits pv
        JOIN pizzeria ON pizzeria.id = pv.pizzeria_id
        JOIN person 
        ON person.id = pv.person_id AND person.gender = 'female'
    )
(SELECT pizzeria_name
FROM man
EXCEPT ALL
SELECT pizzeria_name
FROM woman)

UNION ALL

(SELECT pizzeria_name
FROM woman
EXCEPT ALL
SELECT pizzeria_name
FROM man)

ORDER BY pizzeria_name
