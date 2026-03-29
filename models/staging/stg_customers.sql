with source as (
    select * from {{ ref('seed_customers') }}
)

select
    customer_id,
    customer_name,
    segment,
    industry,
    region,
    customer_status,
    cast(contract_start_date as date) as contract_start_date,
    iff(upper(customer_status) = 'ACTIVE', true, false) as is_active_customer
from source
