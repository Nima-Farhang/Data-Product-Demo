# Import python packages
import streamlit as st
from snowflake.snowpark.context import get_active_session
import time



if "counter" not in st.session_state:
    st.session_state.counter = 0

st.session_state.counter += 1

st.header(f"This page has run {st.session_state.counter} times.")

# Write directly to the app
st.title("Practice app - test- 📖")
st.write(
    """practice
    """
)

# Get the current credentials
session = get_active_session()



if st.checkbox('Show Plot'):

    # Use an interactive slider to get user input
    hifives_val = st.slider(
        "Number of high-fives in Q3",
        min_value=0,
        max_value=90,
        value=60,
        help="Use this to enter the number of high-fives you gave in Q3",
    )
    
    #  Create an example dataframe
    #  Note: this is just some dummy data, but you can easily connect to your Snowflake data
    #  It is also possible to query data using raw SQL using session.sql() e.g. session.sql("select * from table")
    created_dataframe = session.create_dataframe(
        [[50, 25, "Q1"], [20, 35, "Q2"], [hifives_val, 30, "Q3"]],
        schema=["HIGH_FIVES", "FIST_BUMPS", "QUARTER"],
    )
    
    # Execute the query and convert it into a Pandas dataframe
    queried_data = created_dataframe.to_pandas()
    
    # Create a simple bar chart
    # See docs.streamlit.io for more types of charts
    st.subheader("Number of high-fives")
    st.bar_chart(data=queried_data, x="QUARTER", y="HIGH_FIVES")
    
    st.subheader("Underlying data")
    st.dataframe(queried_data, use_container_width=True)



if st.checkbox('Show dataframe'):
    
    filter = st.sidebar.text_input(label= 'Filter',value="NETACT")
    sql = f"select * from dev_wni.meta.metric_list where source like '%{filter}%' limit 20"
    data = session.sql(sql).to_pandas()


    data




if st.checkbox('Shor progrees'):
    left_column, right_column = st.columns(2)

    with left_column:
        
        # You can use a column just like st.sidebar:
        if st.button('Press me!'):
        
        
            latest_iteration = st.empty()
            bar = st.progress(0)
            
            for i in range(100):
              # Update the progress bar with each iteration.
              latest_iteration.text(f'Iteration {i+1}')
              bar.progress(i + 1)
              time.sleep(0.1)
        
            '...and now we\'re done!'
    
    # Or even better, call Streamlit functions inside a "with" block:
    with right_column:
        chosen = st.radio(
            'Sorting hat',
            ("Gryffindor", "Ravenclaw", "Hufflepuff", "Slytherin"))
        st.write(f"You are in {chosen} house!")






