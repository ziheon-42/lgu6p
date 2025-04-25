-- 테이블 생성

-- 데이터베이스 > 테이블(pandas 데이터프레임과 동격)
-- 데이터베이스 안에 있는 것
---- 테이블 외에도 view, 프로시저, 트리거 등도 포함
-- SQL, SQEL: E- English 
-- 문법이 영어 문법과 매우 흡사
-- 표준 SQL, 99% 비슷, 1% 다름 => 데이터 타입 정의할 때 차이가 조금 있음(DB 종류마다)

-- 데이터 확인
SELECT *FROM staff;

USE lily_book;
SELECT * FROM staff;
SELECT * FROM lily_book.dbo.staff;


USE BikeStore;
SELECT * FROM production.brands;

-- 데이터 분석의 모든 것
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY
-- FROM A pandas dataframe SELECT column과 아래 동일
-- SELECT employee_id FROM staff;
-- staff.loc[:, 'employee_id']

-- p.42 SELECT 절과 FROM절
---- SELECT는 특정 컬럼 정보를 주어야 함
USE lily_book;
SELECT employee_id, employee_name, birth_date FROM staff
; -- 해당 쿼리 코드 작성 완료

---- 강사님 추천(가독성 좋게 작성하기)
USE lily_book;
SELECT ep_id               -- 사원 ID
		, ep_name              -- 사원명
		, birth_date 
FROM staff
; -- 해당 쿼리 코드 작성 완료

SELECT * FROM staff;
SELECT employee_name, employee_id FROM staff; -- 컬럼 순서 변경 가능

-- 컬럼 별칭
-- 컬럼명 지정할 때는, 영어 약어로 지정 ==> 데이터 정의서를 남겨서 관리
-- ALIAS (AS)
SELECT employee_id, birth_date AS dbo
FROM staff
;

SELECT employee_id, birth_date AS 생년월일
FROM staff
;

-- DISTINCT 중복값 제거
SELECT * FROM staff;

SELECT DISTINCT gender FROM staff;

SELECT gender FROM staff;


SELECT employee_name, gender, position FROM staff;

SELECT DISTINCT position, gender, employee_name FROM staff;

-- 문자열 함수: 다른 DBMS와 문법 유사, 블로그에 정리 추천
SELECT * FROM apparel_product_info;

-- LEFT 함수
SELECT product_id, LEFT(product_id, 2) AS 약어
FROM apparel_product_info;

-- SUBSTRING : 문자열 중간 N번째 자리부터 N개만 출력
-- SUBSTRING(컬럼명, 숫자(N start), 숫자(N end))
-- 파이썬, 다른 프로그래밍 언어는 인덱스 번호가 0번부터 시작
-- MS-SQL은 인덱스가 1번부터 시작
SELECT product_id,SUBSTRING(product_id, 3, 5) AS 약어
FROM apparel_product_info;

-- CONCAT : 문자열과 문자열 이어서 출력
SELECT CONCAT(category1, '>', category2, '=', '옷', price) AS 테스트
FROM apparel_product_info;

-- REPLACE : 문자열에서 특정 문자 변경(58p)
--                                 변경할대상 변경될대상
SELECT product_id, REPLACE(product_id, 'F',    'A') AS 결과
FROM apparel_product_info;

-- ISNULL [!]중요
-- WHERE절과 함께 쓰일 때 자주 활용됨
-- 데이터상에 결측치가 존재할 때 꼭 필요한 함수
SELECT * FROM apparel_product_info;

-- 숫자함수 : ABS, CEILING, FLOOR, ROUND, POWER, SQRT
-- 다른 DBMS, MySQL, Oracle
SELECT ROUND(CAST (748.58 AS DECIMAL (6, 2)), -3);

-- SIGN
SELECT SIGN(-125), SIGN(0), SIGN(564);  

-- CEILING : 특정 숫자를 올림처리
SELECT * FROM sales;
SELECT sales_amount_usd
		, CEILING(sales_amount_usd) AS 결과
FROM sales;

-- 날짜함수 : 공식문서 무조건 참조
-- GETDATE : 공식문서 참조
-- DATEADD : 공식문서 참조
-- DATEDIFF : 255P 재구매율 구할 때 사용
SELECT 
	order_date
	, DATEADD(YEAR, -1, order_date) AS 결과1
	, DATEADD(YEAR, +2, order_date) AS 결과2
	, DATEADD(DAY, +40, order_date) AS 결과2
FROM sales

-- DATEDIFF (p72)
SELECT
	order_date
	, DATEDIFF(MONTH, order_date, '2025-04-22') 함수적용결과1
FROM sales;


SELECT DATEDIFF(DAY, '1998-04-02', '2025-04-22');

-- 순위함수(p74), 윈도우 함수 ==> 살짝 난해함
SELECT * FROM student_math_score;
SELECT
	학생
	, 수학점수
	, RANK() OVER(ORDER BY 수학점수 DESC) AS rank등수
	, DENSE_RANK() OVER(ORDER BY 수학점수 DESC) AS dense_rank등수
	, ROW_NUMBER() OVER(ORDER BY 수학점수 DESC) AS row_number등수
FROM student_math_score

-- PARTITION BY
-- OVER(ORDER BY) : 전체 중에서 몇 등
-- OVER(PATITION BY class ORDER BY) : 반 별로 나눴을 때 반에서 몇 등?
SELECT * FROM student_math_score;
SELECT
	학생
	, Class
	, 수학점수
	, DENSE_RANK() OVER(ORDER BY 수학점수 DESC) AS 전교등수
	, ROW_NUMBER() OVER(PARTITION BY Class ORDER BY 수학점수 DESC) AS 반등수
FROM student_math_score
;

-- CASE문, 조건문(IF문 대신 사용)
-- SELECT 문 사용시 조회ㅣ용
-- PL/SQL 쓸 경우 IF문 사용 가능 

-- 값이 0보다 작다면 '환불거래', 0보다 크다면 '정상 거래'로 분류
SELECT 
	sales_amount
	, CASE WHEN sales_amount < 0 THEN '환불거래'
			WHEN sales_amount > 0 THEN '정상거래' END AS 적용결과
FROM sales

-- 집계함수

-- 실습_고객 정보 데이터
---- 실행결과의 FULLNAME 칼럼처럼 고객의 전체 이름 출력
SELECT *FROM customer;
SELECT CONCAT(last_name,first_name) AS fullname --CONCAT: 여러개의 문자열 하나로 이어붙이는 함수
FROM customer

---- 실행결과의 CONCAT_INFO 칼럼처럼 고객 연락처 출력
----(핸드폰 번호가 있다면 핸드폰 번호 출력, 그렇지 않으면 이메일 정보 출력)
SELECT ISNULL(phone_number,email) AS contact_info
FROM customer

---- 실행 결과의 AGE 칼럼처럼 고객의 나이를 출력
---- 현재 시점(2023년)을 기준으로 나이 계산(만나이)
SELECT 2023-YEAR(date_of_birth) AS age
FROM customer

---- 실행 결과의 AGEBAND 칼럼처럼 고객의 연령대 정보 확인
---- 10살 단위로 출력
SELECT 
	CASE 
	WHEN 2023-YEAR(date_of_birth) BETWEEN 20 AND 29 THEN '20대'
	WHEN 2023-YEAR(date_of_birth) BETWEEN 30 AND 39 THEN '30대'
	WHEN 2023-YEAR(date_of_birth) BETWEEN 40 AND 49 THEN '40대'
	END AS ageband
FROM customer

---- Q1~Q4의 결과를 바탕으로 다음과 같은 실행 결과 출력
SELECT customer_id
		, CONCAT(last_name,first_name) AS fullname
		, ISNULL(phone_number,email) AS contact_info
		, 2023-YEAR(date_of_birth) AS age
		, CASE WHEN 2023 - YEAR(date_of_birth) BETWEEN 20 AND 29 THEN '20대'
				WHEN 2023 - YEAR(date_of_birth) BETWEEN 30 AND 39 THEN '30대'
				WHEN 2023 - YEAR(date_of_birth) BETWEEN 40 AND 49 THEN '40대'
				END AS ageband
FROM customer
