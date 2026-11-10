CREATE SEQUENCE seq_person_discounts START 1;
SELECT setval('seq_person_discounts', (SELECT COUNT(*) +1 FROM person_discounts));

ALTER TABLE person_discounts
    ALTER COLUMN id set DEFAULT nextval('seq_person_discounts');

    SELECT count(*) = 1 AS check1,
       max("start_value") = 1 AS check2,
       max("last_value") > 5 AS check3
FROM pg_sequences
WHERE sequencename = 'seq_person_discounts';