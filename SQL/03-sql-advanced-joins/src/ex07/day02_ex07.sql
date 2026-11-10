WITH 
    d AS (
        SELECT * FROM person p 
        WHERE name = 'Dmitriy'
    ),
    dv AS (
        SELECT * 
        FROM person_visits pv 
        JOIN d ON pv.person_id = d.id 
        WHERE visit_date = '2022-01-08'
    ),
    m AS (
        SELECT DISTINCT menu.pizzeria_id 
        FROM menu 
        JOIN dv ON dv.pizzeria_id = menu.pizzeria_id 
        WHERE price < 800
    )
SELECT  name
FROM pizzeria p
JOIN m ON p.id = m.pizzeria_id;
