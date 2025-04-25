import numpy as np
import scipy as scipy

# 기존 교육 방법 점수
old_method_scores = np.array([75, 78, 72, 70, 74, 77, 73])

# 새로운 교육 방법 점수
new_method_scores = np.array([82, 85, 88, 90, 86, 87, 84])

from scipy import stats
t_stat, p_value = stats.ttest_ind(new_method_scores, old_method_scores)

print("t-통계량:", t_stat)

print("p-value:", p_value)

alpha = 0.05 #유의 수준 5%(우연이라 보기엔 너무 작다는 판단 기준으로 흔히 사용)
if p_value < alpha:
	print("대립가설 채택")
else:
	print("귀무가설 채택")