SELECT 
    piz.name,
    COUNT(*) AS count_of_orders,
    ROUND(AVG(m.price), 2) AS average_price,
    MAX(m.price) AS max_price,
    MIN(m.price) AS min_price
FROM pizzeria piz
JOIN menu m ON piz.id = m.pizzeria_id
JOIN person_order po ON po.menu_id = m.id
GROUP BY piz.name
ORDER BY 1;
