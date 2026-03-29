with tickets as (
    select * from {{ ref('fct_support_tickets') }}
)

select
    opened_date,
    region,
    segment,
    owner_team,
    priority,
    issue_type,
    status,
    count(distinct ticket_id) as ticket_count,
    avg(ticket_age_days) as average_ticket_age_days,
    sum(case when is_resolved then 1 else 0 end) as resolved_ticket_count,
    sum(case when not is_resolved then 1 else 0 end) as open_ticket_count
from tickets
group by 1, 2, 3, 4, 5, 6, 7
