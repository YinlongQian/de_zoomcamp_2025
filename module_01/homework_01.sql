-- SELECT *
-- FROM public."green_tripdata_2019-10"
-- where CAST(lpep_pickup_datetime AS DATE) >= '2019-10-01'
-- and CAST(lpep_dropoff_datetime AS DATE) < '2019-11-01'
-- and trip_distance >7
-- and trip_distance <=10

-- SELECT max(trip_distance) as max_di, CAST(lpep_pickup_datetime AS DATE) as da
-- FROM public."green_tripdata_2019-10"
-- GROUP BY da
-- ORDER BY max_di DESC

-- SELECT t."Zone", SUM(g.total_amount)
-- FROM public."green_tripdata_2019-10" as g
-- LEFT JOIN public."taxi_zone_lookup" as t
-- ON g."PULocationID" = t."LocationID"
-- WHERE CAST(g.lpep_pickup_datetime AS DATE) = '2019-10-18'
-- GROUP BY t."Zone"
-- ORDER BY SUM(g.total_amount) DESC


SELECT g."DOLocationID", MAX(g.tip_amount)
FROM public."green_tripdata_2019-10" as g
LEFT JOIN public."taxi_zone_lookup" as t
ON g."PULocationID" = t."LocationID"
WHERE CAST(g.lpep_pickup_datetime AS DATE) >= '2019-10-01'
AND CAST(g.lpep_pickup_datetime AS DATE) < '2019-11-01'
AND t."Zone" = 'East Harlem North'
GROUP BY g."DOLocationID"
ORDER BY MAX(g.tip_amount) DESC