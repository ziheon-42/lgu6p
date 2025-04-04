import streamlit as st
import pandas as pd
import seaborn as sns
import plotly.express as px
import plotly.graph_objects as go

st.title("Plotly 튜토리얼")

# tips 데이터셋 가져오기
tips = sns.load_dataset('tips')

# 데이터 미리보기
st.subheader('데이터 미리보기')
st.dataframe(tips.head())

# 기본 막대 그래프
st.subheader("1. 기본 막대 그래프")
fig = px.bar(tips, x = 'day', 
             y = 'tip', 
             title = '요일별 지불 금액',
             labels={'day':'요일', 'tip': '평균 tip($)'})
st.plotly_chart(fig, use_container_width=True)

# 산점도
st.subheader("2. 산점도")
fig1 = px.scatter(tips, 
    x = 'total_bill',
    y = 'tip',
    color = 'sex',
    size = 'size',
    hover_data= ['day', 'time', 'smoker', 'size'], #hover 시 보여줄 데이터 지정
    title='Total_Bill vs Tip with Hover Info')
    
st.plotly_chart(fig1)

