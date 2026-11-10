(SELECT 
    piz.name AS name,
    COUNT (*) AS count,
   'order' AS action_type
FROM person_order po
JOIN menu m ON m.id = po.menu_id
JOIN pizzeria piz ON piz.id = m.pizzeria_id
GROUP BY piz.name
ORDER BY 2 DESC
LIMIT 3)

UNION ALL

(SELECT 
    piz.name AS name,
    COUNT (*) AS count,
   'visit' AS action_type
FROM person_visits pv
JOIN pizzeria piz ON piz.id = pv.pizzeria_id
GROUP BY piz.name
ORDER BY 2 DESC
LIMIT 3)

ORDER BY 3 ASC, 2 DESC;

