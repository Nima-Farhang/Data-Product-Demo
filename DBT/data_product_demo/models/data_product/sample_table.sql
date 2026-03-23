{{ config(materialized='table',alias='APP_SAMPLE_TABLE') }}

with source_data as (

        select 1 as id
        union all
        select null as id

    )

select *
from source_data