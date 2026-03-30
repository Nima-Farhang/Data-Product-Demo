import streamlit as st
from snowflake.snowpark.context import get_active_session

st.set_page_config(page_title="Service Operations", page_icon="🛠️", layout="wide")

st.title("🛠️ Service Operations")
st.caption("Operations demo app for the sample data product")

session = get_active_session()

kpi_query = """
select
    count_if(not is_resolved) as open_tickets,
    count(*) as total_tickets,
    avg(ticket_age_days) as average_ticket_age_days
from ANALYTICS.fct_support_tickets
"""

priority_query = """
select
    priority,
    count(*) as ticket_count
from ANALYTICS.fct_support_tickets
group by priority
order by ticket_count desc
"""

issue_type_query = """
select
    issue_type,
    count(*) as ticket_count
from ANALYTICS.fct_support_tickets
group by issue_type
order by ticket_count desc
"""

customer_query = """
select
    customer_name,
    count(*) as open_ticket_count
from ANALYTICS.fct_support_tickets
where not is_resolved
group by customer_name
order by open_ticket_count desc, customer_name
limit 10
"""

team_query = """
select
    owner_team,
    count(*) as ticket_count
from ANALYTICS.fct_support_tickets
group by owner_team
order by ticket_count desc
"""

overdue_query = """
select
    ticket_id,
    customer_name,
    priority,
    status,
    owner_team,
    ticket_age_days
from ANALYTICS.fct_support_tickets
where not is_resolved
order by ticket_age_days desc, priority desc
limit 20
"""

kpis = session.sql(kpi_query).to_pandas()
priority = session.sql(priority_query).to_pandas()
issue_types = session.sql(issue_type_query).to_pandas()
customers = session.sql(customer_query).to_pandas()
teams = session.sql(team_query).to_pandas()
overdue = session.sql(overdue_query).to_pandas()

col1, col2, col3 = st.columns(3)
col1.metric("Open tickets", f"{int(kpis.iloc[0]['OPEN_TICKETS']):,}")
col2.metric("Total tickets", f"{int(kpis.iloc[0]['TOTAL_TICKETS']):,}")
col3.metric("Average ticket age (days)", f"{float(kpis.iloc[0]['AVERAGE_TICKET_AGE_DAYS']):.1f}")

left, right = st.columns(2)
with left:
    st.subheader("Tickets by priority")
    st.bar_chart(priority.set_index("PRIORITY"))
with right:
    st.subheader("Tickets by owner team")
    st.bar_chart(teams.set_index("OWNER_TEAM"))

left, right = st.columns(2)
with left:
    st.subheader("Issue type distribution")
    st.dataframe(issue_types, use_container_width=True)
with right:
    st.subheader("Customers with open tickets")
    st.dataframe(customers, use_container_width=True)

st.subheader("Oldest open tickets")
st.dataframe(overdue, use_container_width=True)
