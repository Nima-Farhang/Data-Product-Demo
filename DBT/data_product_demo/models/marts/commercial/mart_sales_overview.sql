with orders as (
    select * from {{ ref('fct_orders') }}
    where upper(order_status) = 'COMPLETED'
)

select
    order_month,
    region,
    segment,
    product_category,
    product_name,
    count(distinct order_id) as completed_orders,
    count(distinct customer_id) as unique_customers,
    sum(quantity) as total_quantity,
    sum(revenue_nzd) as total_revenue_nzd
from orders
group by 1, 2, 3, 4, 5
