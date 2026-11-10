WITH
    pam AS (
        SELECT * FROM menu 
        WHERE 
            pizza_name IN ('pepperoni pizza', 'mushroom pizza')
    ),
    po AS (
        SELECT * FROM person_order 
        JOIN pam ON person_order.menu_id = pam.id 
    ),
    msksmr AS (
        SELECT DISTINCT name FROM person JOIN po ON po.person_id = person.id 
        WHERE address IN ('Moscow', 'Samara') AND gender = 'male'
    )
SELECT name
FROM msksmr
ORDER BY name DESC;