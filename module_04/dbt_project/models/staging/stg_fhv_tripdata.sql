{{
    config(
        materialized='view'
    )
}}

select *
from {{ source('staging','fhv_tripdata_external') }}
where dispatching_base_num is not null 