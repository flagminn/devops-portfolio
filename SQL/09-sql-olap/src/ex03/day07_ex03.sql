SELECT 
    name AS name,
    SUM(count) AS total_count
FROM 
   ( (SELECT 
        piz.name AS name,
        COUNT (*) AS count
    
    FROM person_order po
    JOIN menu m ON m.id = po.menu_id
    JOIN pizzeria piz ON piz.id = m.pizzeria_id
    GROUP BY piz.name
    ORDER BY 2 DESC)

    UNION ALL

    (SELECT 
        piz.name AS name,
        COUNT (*) AS count
    
    FROM person_visits pv
    JOIN pizzeria piz ON piz.id = pv.pizzeria_id
    GROUP BY piz.name
    ORDER BY 2 DESC))
GROUP BY name


ORDER BY 2 DESC, 1 ASC;

