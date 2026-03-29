select
    orders.order_id,
    orders.order_date,
    orders.order_month,
    orders.customer_id,
    customers.customer_name,
    customers.segment,
    customers.industry,
    customers.region,
    orders.product_id,
    products.product_name,
    products.category as product_category,
    orders.quantity,
    orders.unit_price_nzd,
    orders.revenue_nzd,
    orders.sales_channel,
    orders.order_status
from {{ ref('stg_orders') }} as orders
left join {{ ref('dim_customers') }} as customers
    on orders.customer_id = customers.customer_id
left join {{ ref('dim_products') }} as products
    on orders.product_id = products.product_id
