SELECT 
    p.name AS name,
    pizza_name,
    price,
    (price * (1 - pd.discount/100))::numeric(10,0) AS discount_price,
    piz.name AS pizzeria_name
FROM menu m
JOIN pizzeria piz ON piz.id = m.pizzeria_id
JOIN person_order po ON po.menu_id = m.id
JOIN person  p ON p.id = po.person_id
JOIN person_discounts pd ON p.id = pd.person_id
AND piz.id = pd.pizzeria_id
ORDER BY 1, 2;