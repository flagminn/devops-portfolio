SELECT COALESCE(person.name, '-') person_name, 
pv.visit_date visit_date, 
COALESCE (pizzeria.name, '-') pizzeria_name
FROM 
(SELECT * FROM person_visits WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-03') as pv

FULL JOIN
    pizzeria ON pv.pizzeria_id = pizzeria.id
FULL JOIN 
    person ON person.id = pv.person_id
ORDER BY 1, 2, 3;
