
-- SHOW TRANSACTION ISOLATION LEVEL;
-- Session #1
BEGIN;
-- Session #2
BEGIN;
-- Session #1
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
-- Session #2
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
-- Session #1
UPDATE pizzeria SET rating = 4 WHERE name = 'Pizza Hut';
-- Session #2
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';
-- В этот момент Сессия №2 заблокирована (ждет решения Сессии №1)

-- Session #1
COMMIT;
-- После этого Сессия №2 автоматически разблокируется и выполнит свой UPDATE

-- Session #2
COMMIT;
-- Session #1
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
-- Session #2
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';