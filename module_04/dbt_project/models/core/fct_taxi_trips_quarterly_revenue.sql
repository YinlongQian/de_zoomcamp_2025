{{
    config(
        materialized='table'
    )
}}

with tripdata as (
    select *
    from {{ ref('fact_trips') }}
),
QuarterlyRevenue AS (
    SELECT
        -- EXTRACT(YEAR FROM revenue_date) AS year,
        -- EXTRACT(QUARTER FROM revenue_date) AS quarter,
        -- SUM(revenue_amount) AS total_revenue
        service_type,
        cast({{ dbt_date.date_part('year', 'pickup_datetime') }} as {{ dbt.type_int() }}) as year,
        cast({{ dbt_date.date_part('quarter', 'pickup_datetime') }} as {{ dbt.type_int() }}) as quarter,
        sum(total_amount) as total_revenue
    from tripdata
    group by 1,2,3
),
YoYRevenue AS (
    SELECT
        current_1.service_type,
        current_1.year AS current_year,
        current_1.quarter AS current_quarter,
        current_1.total_revenue AS current_revenue,
        previous.total_revenue AS previous_revenue,
        -- Calculate YoY Growth
        ((current_1.total_revenue - previous.total_revenue) / previous.total_revenue) * 100 AS yoy_growth_percentage
    FROM
        QuarterlyRevenue current_1
    LEFT JOIN
        QuarterlyRevenue previous
    ON
        current_1.service_type = previous.service_type
        AND current_1.quarter = previous.quarter
        AND current_1.year = previous.year + 1  -- Previous year
)
SELECT
    service_type,
    current_year,
    current_quarter,
    current_revenue,
    previous_revenue,
    yoy_growth_percentage
FROM
    YoYRevenue
ORDER BY
    current_year ASC, current_quarter ASC, service_type ASC
