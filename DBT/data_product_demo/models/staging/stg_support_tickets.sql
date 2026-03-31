with source as (
    select * from {{ ref('seed_support_tickets') }}
)

select
    ticket_id,
    cast(opened_date as date) as opened_date,
    cast(closed_date as date) as closed_date,
    customer_id,
    issue_type,
    priority,
    status,
    owner_team,
    datediff('day', cast(opened_date as date), coalesce(cast(closed_date as date), current_date())) as ticket_age_days,
    iff(upper(status) in ('RESOLVED', 'CLOSED'), true, false) as is_resolved
from source
