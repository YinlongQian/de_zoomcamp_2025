{{
    config(
        materialized='table'
    )
}}

with tripdata as (
    select *
    from {{ ref('fact_trips') }}
    where fare_amount > 0
    AND trip_distance > 0
    AND payment_type_description IN ('Cash', 'Credit Card')
)

SELECT
    service_type,
    EXTRACT(YEAR FROM pickup_datetime) AS year,
    EXTRACT(MONTH FROM pickup_datetime) AS month,
    PERCENTILE_CONT(fare_amount, 0.97) OVER (PARTITION BY service_type) AS p_97,
    PERCENTILE_CONT(fare_amount, 0.95) OVER (PARTITION BY service_type) AS p_95,
    PERCENTILE_CONT(fare_amount, 0.90) OVER (PARTITION BY service_type) AS p_90
FROM
    tripdata
WHERE
    EXTRACT(YEAR FROM pickup_datetime) = 2020
    AND EXTRACT(MONTH FROM pickup_datetime) = 4
-- ORDER BY
--     service_type,
--     year DESC,
--     month DESC;
