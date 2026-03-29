with source as (
    select * from {{ ref('seed_products') }}
)

select
    product_id,
    product_name,
    category,
    cast(base_price_nzd as number(18,2)) as base_price_nzd
from source
