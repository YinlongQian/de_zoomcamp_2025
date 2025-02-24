{{
    config(
        materialized='table'
    )
}}

with dim_fhv_trips as (
    select
    *,
    {{ datediff("pickup_datetime", "dropoff_datetime", "second") }} as trip_duration
     from {{ ref('dim_fhv_trips') }}
)
    select
    pickup_year,
    pickup_month,
    pickup_datetime,
    pickup_locationid,
    pickup_zone,
    dropoff_datetime,
    dropoff_locationid,
    dropoff_zone,
    trip_duration,
    PERCENTILE_CONT(trip_duration, 0.90) OVER (PARTITION BY pickup_year, pickup_month, pickup_locationid, dropoff_locationid) AS p_90,
    from dim_fhv_trips