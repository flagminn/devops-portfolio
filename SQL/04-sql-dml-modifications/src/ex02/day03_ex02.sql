WITH 
    m_id AS (
        SELECT id
        FROM menu
        EXCEPT
        SELECT menu_id
        FROM person_order
    ) 
SELECT 
    DISTINCT pizza_name,
    price,
    pizzeria.name AS pizzeria_name
FROM pizzeria
JOIN menu ON pizzeria.id = menu.pizzeria_id
JOIN m_id ON menu.id = m_id.id
ORDER BY 1, 2

