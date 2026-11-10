SELECT 
    address,
    ROUND(MAX(p.age::NUMERIC) - (MIN(p.age::NUMERIC) / MAX(p.age::NUMERIC)),2) AS formula,
    ROUND(AVG(p.age),2) AS average,
    (MAX(age::numeric) - (MIN(age::numeric) / MAX(age::numeric))) > AVG(age) AS comparison
FROM person p
GROUP BY address
ORDER BY 1;
