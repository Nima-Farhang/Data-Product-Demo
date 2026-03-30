import streamlit as st
from snowflake.snowpark.context import get_active_session

st.set_page_config(page_title="Sales Overview", page_icon="💼", layout="wide")

st.title("💼 Sales Overview")
st.caption("Commercial demo app for the sample data product")

session = get_active_session()

kpi_query = """
select
    coalesce(sum(total_revenue_nzd), 0) as total_revenue_nzd,
    coalesce(sum(completed_orders), 0) as completed_orders,
    coalesce(sum(unique_customers), 0) as unique_customers
from ANALYTICS.mart_sales_overview
"""

monthly_query = """
select
    order_month,
    sum(total_revenue_nzd) as total_revenue_nzd
from ANALYTICS.mart_sales_overview
group by order_month
order by order_month
"""

region_query = """
select
    region,
    sum(total_revenue_nzd) as total_revenue_nzd
from ANALYTICS.mart_sales_overview
group by region
order by total_revenue_nzd desc
"""

customer_query = """
select
    customer_name,
    sum(revenue_nzd) as total_revenue_nzd
from ANALYTICS.fct_orders
where upper(order_status) = 'COMPLETED'
group by customer_name
order by total_revenue_nzd desc
limit 10
"""

product_query = """
select
    product_name,
    sum(revenue_nzd) as total_revenue_nzd
from ANALYTICS.fct_orders
where upper(order_status) = 'COMPLETED'
group by product_name
order by total_revenue_nzd desc
limit 10
"""

kpis = session.sql(kpi_query).to_pandas()
monthly = session.sql(monthly_query).to_pandas()
region = session.sql(region_query).to_pandas()
customers = session.sql(customer_query).to_pandas()
products = session.sql(product_query).to_pandas()

col1, col2, col3 = st.columns(3)
col1.metric("Total revenue (NZD)", f"{kpis.iloc[0]['TOTAL_REVENUE_NZD']:,.0f}")
col2.metric("Completed orders", f"{int(kpis.iloc[0]['COMPLETED_ORDERS']):,}")
col3.metric("Unique customers", f"{int(kpis.iloc[0]['UNIQUE_CUSTOMERS']):,}")

st.subheader("Monthly revenue")
st.line_chart(monthly.set_index("ORDER_MONTH"))

left, right = st.columns(2)
with left:
    st.subheader("Revenue by region")
    st.bar_chart(region.set_index("REGION"))
with right:
    st.subheader("Top customers")
    st.dataframe(customers, use_container_width=True)

st.subheader("Top products")
st.dataframe(products, use_container_width=True)
