select
    product_id,
    product_name,
    category,
    base_price_nzd
from {{ ref('stg_products') }}
