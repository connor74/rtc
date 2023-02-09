WITH last_date AS (
	SELECT MAX("date") AS dt
	FROM rtk.test_sql_py 
	WHERE "date" < '2022-07-04' -- CURRENT_DATE
)
SELECT *
FROM rtk.test_sql_py tsp 
JOIN last_date ld ON tsp."date" = ld.dt;
