select
    customer_id,
    customer_name,
    segment,
    industry,
    region,
    customer_status,
    contract_start_date,
    is_active_customer
from {{ ref('stg_customers') }}
