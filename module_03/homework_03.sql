CREATE OR REPLACE EXTERNAL TABLE `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_external`
OPTIONS (
  format = 'parquet',
  uris = ['gs://zoomcamp-misc/yellow_trip_data/2024/yellow_tripdata_2024-*.parquet']
);

CREATE OR REPLACE TABLE `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_nonpartitioned`
AS SELECT * FROM `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_external`;

CREATE OR REPLACE MATERIALIZED VIEW `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_nonpartitioned_mv`
AS SELECT * FROM `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_nonpartitioned`;

SELECT COUNT(DISTINCT(PULocationID))
FROM `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_external`;

SELECT COUNT(DISTINCT(PULocationID))
FROM `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_nonpartitioned_mv`;

SELECT PULocationID
FROM `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_nonpartitioned_mv`;

SELECT PULocationID, DOLocationID
FROM `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_nonpartitioned_mv`;

SELECT COUNT(*)
FROM `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_nonpartitioned_mv`
WHERE fare_amount = 0;

CREATE OR REPLACE TABLE `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_partitioned`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID AS
SELECT * FROM `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_nonpartitioned`;

SELECT DISTINCT(VendorID)
FROM `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_nonpartitioned_mv`
WHERE DATE(tpep_dropoff_datetime) >= '2024-03-01' AND DATE(tpep_dropoff_datetime) <= '2024-03-15';

SELECT DISTINCT(VendorID)
FROM `de-zoomcampfire.zoomcamp.yellow_trip_data_2024_partitioned`
WHERE DATE(tpep_dropoff_datetime) >= '2024-03-01' AND DATE(tpep_dropoff_datetime) <= '2024-03-15';