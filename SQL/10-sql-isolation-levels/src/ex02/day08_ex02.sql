-- Session #1
BEGIN ISOLATION LEVEL REPEATABLE READ;
-- Session #2
BEGIN ISOLATION LEVEL REPEATABLE READ;

-- Session #1
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
-- Session #2
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- Session #1
UPDATE pizzeria SET rating = 4 WHERE name = 'Pizza Hut';
-- Session #2
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';

-- Session #1
COMMIT;
-- Session #2:  ошибкa (ERROR: could not serialize access...)
-- После ошибки транзакция в Session #2 становится невалидной.
ROLLBACK;


-- Session #1
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
-- Session #2
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';