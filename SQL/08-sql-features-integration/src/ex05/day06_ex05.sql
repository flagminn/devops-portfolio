COMMENT ON TABLE person_discounts IS 'Таблица для хранения персональных скидок клиентов в конкретных пиццериях';
COMMENT ON COLUMN person_discounts.id IS 'Первичный ключ записи';
COMMENT ON COLUMN person_discounts.person_id IS 'Идентификатор клиента (ссылка на таблицу person)';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Идентификатор пиццерии (ссылка на таблицу pizzeria)';
COMMENT ON COLUMN person_discounts.discount IS 'Размер персональной скидки в процентах (0.00 - 100.00)';
