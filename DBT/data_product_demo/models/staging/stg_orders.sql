with source as (
    select * from {{ ref('seed_orders') }}
)

select
    order_id,
    cast(order_date as date) as order_date,
    customer_id,
    product_id,
    cast(quantity as number(18,0)) as quantity,
    cast(unit_price_nzd as number(18,2)) as unit_price_nzd,
    cast(revenue_nzd as number(18,2)) as revenue_nzd,
    sales_channel,
    order_status,
    date_trunc('month', cast(order_date as date)) as order_month
from source
