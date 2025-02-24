{{
    config(
        materialized='table'
    )
}}

with tripdata as (
    select * from {{ ref('stg_fhv_tripdata') }}
),
dim_zones as (
    select * from {{ ref('taxi_zone_lookup') }}
    where borough != 'Unknown'
)
    select

    tripdata.dispatching_base_num,

    cast({{ dbt_date.date_part('year', 'tripdata.pickup_datetime') }} as {{ dbt.type_int() }}) as pickup_year,
    cast({{ dbt_date.date_part('month', 'tripdata.pickup_datetime') }} as {{ dbt.type_int() }}) as pickup_month,

    tripdata.pickup_datetime,
    tripdata.PUlocationID as pickup_locationid, 
    d1.borough as pickup_borough, 
    d1.zone as pickup_zone, 

    tripdata.dropoff_datetime,
    tripdata.DOlocationID as dropoff_locationid,
    d2.borough as dropoff_borough, 
    d2.zone as dropoff_zone,

    tripdata.SR_Flag,
    tripdata.Affiliated_base_number

    from tripdata
    inner join dim_zones d1 on tripdata.pulocationid = d1.locationid
    inner join dim_zones d2 on tripdata.dolocationid = d2.locationid