import matplotlib.pyplot as plt
import numpy as np

# 예시 데이터
data = [22, 40, 53, 57, 93, 98, 103, 108, 116, 121, 252]

# 사분위수 계산
Q1 = np.percentile(data, 25)
Q2 = np.percentile(data, 50)
Q3 = np.percentile(data, 75)

# 박스 플롯 그리기
plt.boxplot(data)
plt.title("Boxplot with Quartiles")
plt.show()

print(f"1사분위수: {Q1}")
print(f"중앙값: {Q2}")
print(f"3사분위수: {Q3}")