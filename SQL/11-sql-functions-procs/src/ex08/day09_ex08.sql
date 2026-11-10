CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop INTEGER DEFAULT 10)
RETURNS TABLE (num INTEGER) AS $$
    WITH RECURSIVE fib(a, b) AS (
        -- Стартовая точка: явно называем колонки
        SELECT 0 AS a, 1 AS b
        UNION ALL
        -- Рекурсия: берем предыдущее 'b' и считаем сумму
        SELECT b, a + b
        FROM fib
        WHERE b < pstop
    )
    -- В конце выбираем только колонку 'a'
    SELECT a FROM fib;
$$ LANGUAGE sql;


select * from fnc_fibonacci(100);

select * from fnc_fibonacci();