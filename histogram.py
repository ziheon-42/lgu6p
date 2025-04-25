## 도수분포(히스토그램)
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# 예시 데이터(100개의 난수)
data = np.random.normal(loc=0,scale=1, size=100)

#히스토그램 그리기
sns.histplot(data, kde = True)
plt.title("Histogram with KDE")
plt.show()