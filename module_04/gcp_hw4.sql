CREATE OR REPLACE EXTERNAL TABLE `de-zoomcampfire.module_04.green_tripdata_external`
OPTIONS (
  format = 'csv',
  uris = [
    'gs://zoomcamp-misc/green_tripdata/2019/green_tripdata_2019-*.csv',
    'gs://zoomcamp-misc/green_tripdata/2020/green_tripdata_2020-*.csv'
  ]
);

CREATE OR REPLACE EXTERNAL TABLE `de-zoomcampfire.module_04.yellow_tripdata_external`
OPTIONS (
  format = 'csv',
  uris = [
    'gs://zoomcamp-misc/yellow_tripdata/2019/yellow_tripdata_2019-*.csv',
    'gs://zoomcamp-misc/yellow_tripdata/2020/yellow_tripdata_2020-*.csv'
  ]
);

CREATE OR REPLACE EXTERNAL TABLE `de-zoomcampfire.module_04.fhv_tripdata_external`
OPTIONS (
  format = 'csv',
  uris = [
    'gs://zoomcamp-misc/fhv_tripdata/2019/fhv_tripdata_2019-*.csv'
  ]
);

SELECT COUNT(*)
FROM `de-zoomcampfire.module_04.green_tripdata_external`;

SELECT COUNT(*)
FROM `de-zoomcampfire.module_04.yellow_tripdata_external`;

SELECT COUNT(*)
FROM `de-zoomcampfire.module_04.fhv_tripdata_external`;


-- For Homework 4, Question 7
SELECT * 
FROM `de-zoomcampfire.dbt_yqian.fct_fhv_monthly_zone_traveltime_p90` 
WHERE 
  pickup_year = 2019
  AND pickup_month = 11
  AND pickup_zone = 'Newark Airport'
ORDER BY p_90 DESC
LIMIT 1000;

SELECT * 
FROM `de-zoomcampfire.dbt_yqian.fct_fhv_monthly_zone_traveltime_p90` 
WHERE 
  pickup_year = 2019
  AND pickup_month = 11
  AND pickup_zone = 'SoHo'
ORDER BY p_90 DESC
LIMIT 1000;

SELECT * 
FROM `de-zoomcampfire.dbt_yqian.fct_fhv_monthly_zone_traveltime_p90` 
WHERE 
  pickup_year = 2019
  AND pickup_month = 11
  AND pickup_zone = 'Yorkville East'
ORDER BY p_90 DESC
LIMIT 1000;






