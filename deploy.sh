#git 명령어 실행
git add .
git commit -m "updated"
git push

2025-04-11 09:59:34
Testing:2025-04-11 10:00:17

#!/bin/bash

# 커밋 메세지 입력 받기
read -p "커밋 메세지를 입력하세요: " user_message

# KST 시간 구하기(UTC+9)
current_time=$(TZ=Asia/Seoul date "+%Y-%m-%d %H:%M:%S")

#전체 메시지 구성
commit_message="$user_message | $current_time (KST)"
