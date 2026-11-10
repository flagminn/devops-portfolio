WITH 
    dron_diff AS (
        (SELECT pizzeria.name AS pizzeria_name
        FROM person
        JOIN person_visits pv ON person.id = pv.person_id
        JOIN pizzeria ON pv.pizzeria_id = pizzeria.id
        WHERE person.name = 'Andrey')
        EXCEPT
        (SELECT pizzeria.name AS pizzeria_name
        FROM person
        JOIN person_order po ON person.id = po.person_id
        JOIN menu m ON m.id = po.menu_id
        JOIN pizzeria ON m.pizzeria_id = pizzeria.id
        WHERE person.name = 'Andrey')
    ) 
SELECT pizzeria_name
FROM dron_diff
ORDER BY 1; 
 


