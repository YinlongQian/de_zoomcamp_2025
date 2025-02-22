{{
    config(
        materialized='view'
    )
}}

with tripdata as 
(
  select *,
    row_number() over(partition by VendorID, lpep_pickup_datetime) as rn
  from {{ source('staging','green_tripdata_external') }}
  where VendorID is not null 
)
select
    rn,
    {{ dbt_utils.generate_surrogate_key(['VendorID', 'lpep_pickup_datetime']) }} as tripid,
    {{ dbt.safe_cast("VendorID", api.Column.translate_type("integer")) }} as vendorid,
from tripdata
where rn = 1


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}