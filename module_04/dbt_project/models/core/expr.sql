{{
    config(
        materialized='table'
    )
}}

with tripdata as (
    select * from {{ ref('fact_trips') }}
)
    select 
    {{ dbt.date_trunc("quarter", "pickup_datetime") }} as revenue_quarter,
    cast({{ dbt_date.date_part('quarter', 'pickup_datetime') }} as {{ dbt.type_int() }}) as quarter_of_year,
    from tripdata