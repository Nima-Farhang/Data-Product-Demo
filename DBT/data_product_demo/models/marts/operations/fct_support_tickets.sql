select
    tickets.ticket_id,
    tickets.opened_date,
    tickets.closed_date,
    tickets.customer_id,
    customers.customer_name,
    customers.segment,
    customers.region,
    tickets.issue_type,
    tickets.priority,
    tickets.status,
    tickets.owner_team,
    tickets.ticket_age_days,
    tickets.is_resolved
from {{ ref('stg_support_tickets') }} as tickets
left join {{ ref('dim_customers') }} as customers
    on tickets.customer_id = customers.customer_id
