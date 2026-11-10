CREATE VIEW v_price_with_discount AS
SELECT 
    p.name,
    m.pizza_name,
    m.price,
    (m.price - m.price * 0.1)::INTEGER AS discount_price
FROM person p
JOIN person_order po ON  po.person_id = p.id
JOIN menu m ON po.menu_id = m.id
ORDER BY 1, 2
