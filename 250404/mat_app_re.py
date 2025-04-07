import streamlit as st
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import matplotlib.font_manager as fm

#st.title("Matplotlib 튜토리얼2")
#streamlit에서는 set_page_config()를 스크립트의 첫번째 streamlit 관련 명령어로 사용해야 함.
#st.set_page_config()이전에 title, write, sidebar 등이 먼저 나오면 안 됨

#폰트 설정
plt.rcParams['font.family'] = 'Malgun Gothic'
plt.rcParams['axes.unicode_minus'] = False
sns.set(font = 'Malgun Gothic',
        rc = {'axes.unicode_minus' : False},
        style = 'darkgrid')

#페이지 설정
st.set_page_config(page_title="Matplotlib & Seaborn 튜토리얼2", layout = "wide")
st.title("Matplotlib & Seaborn 튜토리얼2")

#데이터셋 불러오기
tips = sns.load_dataset('tips')

#데이터 미리보기
st.subheader('데이터 미리보기')
st.dataframe(tips.head())

#기본 막대 그래프, matplotlit + seaborn
st.subheader("1. 기본 막대 그래프")
fig, ax = plt.subplots(figsize=(10, 6))

#seaborn
sns.barplot(data = tips, x = 'day', y = 'total_bill', ax = ax)

#matplotlib
ax.set_title('요일별 평균 지불 금액')
ax.set_xlabel('요일')
ax.set_ylabel('평균지불금액($)')

#treamlit 문법
st.pyplot(fig)
# matplotlib의 그래프를 웹에 출력할 때 사용하는 함수

# 산점도
# x축, y축이 연속형 변수여야 함
st.subheader("2.산점도")
fig1, ax1 = plt.subplots(figsize=(10,6))

#sns.barplot(data = tips, x = 'day', y = 'tip', hue = 'day', size = 'size')
sns.scatterplot(data = tips, x = 'total_bill', y = 'tip', hue = 'day', size = 'size',
ax = ax1)
st.pyplot(fig1)

#히트맵
st.subheader("3. 히트맵")

#요일과 시간별 평균 팁 계산
pivot_df = tips.pivot_table(values = 'tip', index = 'day', columns = 'time', aggfunc = 'mean')
fig2, ax2 = plt.subplots(figsize = (10,6))
sns.heatmap(pivot_df, annot=True, fmt = '.2f', ax=ax2)
st.pyplot(fig2)

#회귀선이 있는 산점도
st.subheader("4. 회귀선이 있는 산점도")
fig3, ax3 = plt.subplots(figsize = (10,6))
sns.regplot(data = tips, x = 'total_bill', y = 'tip', scatter_kws={'alpha':0.5}, ax = ax3)
st.pyplot(fig3)


