CREATE OR REPLACE FUNCTION 
    fnc_person_visits_and_eats_on_date(
        pperson VARCHAR DEFAULT 'Dmitriy', 
        pprice INTEGER DEFAULT 500, 
        pdate DATE DEFAULT '2022-01-08')
RETURNS TABLE (
    name VARCHAR
) AS $$
    SELECT DISTINCT piz.name
    FROM pizzeria piz
    JOIN menu m ON piz.id = m.pizzeria_id
    JOIN person_visits pv ON pv.pizzeria_id = piz.id
    JOIN person p ON p.id = pv.person_id
    WHERE m.price < pprice AND 
        p.name = pperson AND
        pv.visit_date = pdate;
 $$ LANGUAGE sql;

select *  
from fnc_person_visits_and_eats_on_date(pprice := 800);

select * 
from fnc_person_visits_and_eats_on_date(
    pperson := 'Anna',
    pprice := 1300,
    pdate := '2022-01-01');