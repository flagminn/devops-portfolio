WITH RECURSIVE tours AS (
    SELECT DISTINCT
        point1 AS current_point,
        ARRAY[point1]::text[] AS path,
        0 AS total_cost
    FROM nodes
    WHERE point1 = 'a'

    UNION ALL

    SELECT 
        nodes.point2,
        tours.path || nodes.point2,
        tours.total_cost + nodes.cost
    FROM tours
    JOIN nodes ON tours.current_point = nodes.point1
    WHERE 
        NOT nodes.point2 = ANY(tours.path)
),
final_tours AS (
    SELECT 
        tours.total_cost + nodes.cost AS total_cost,
        (tours.path || nodes.point2)::text[] AS tour_array
    FROM tours
    JOIN nodes ON tours.current_point = nodes.point1
    WHERE 
        array_length(tours.path, 1) = 4 
        AND nodes.point2 = 'a'
)
SELECT total_cost, tour
FROM (
    SELECT 
        total_cost,
        '{' || array_to_string(tour_array, ',') || '}' AS tour
    FROM final_tours
) AS results
WHERE total_cost = (SELECT MIN(total_cost) FROM final_tours)
   OR total_cost = (SELECT MAX(total_cost) FROM final_tours)
ORDER BY total_cost, tour;