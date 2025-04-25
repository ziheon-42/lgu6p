-- 교재 WHERE절
-- 조건과 일치하는 데이터 조회(필터링)
-- pandas, iloc, loc, 비교연산자 등 같이 상기
-- 94p
-- 남자 고객만 필터링 후 id, name, gender만 출력
USE lily_book;

-- [!] 문법 주의. "" 안됨. ''만 가능
SELECT 
	*
FROM
	dbo.customer
WHERE customer_id = 'c002'
;

-- WHERER절 안에서 비교연산자 통해서 필터링
-- <>, != : 좌우 식이 서로 같지 않음
SELECT * FROM sales;

-- sales_amount의 양이 양수인 것만 조회
SELECT * FROM sales
WHERE sales_amount > 0;

-- 숫자를 입력할 때 근사하게 입력해보자
SELECT * FROM sales WHERE sales_amount = 41000;

-- 데이터가 아예 없을 때도 NULL 형태로 출력
-- 조회를 할 때, 정확하게 입력하지 않아도 NULL 형태로 출력
---- 41000이 없다고 ERROR가 나는 것이 아니라 NULL 형태로 출력됨
SELECT * FROM customer WHERE customer_id = 'Z002';

-- BETWEEN 연산자(자주 쓰임)_100p
-- 30000과 40000 사이의 조건을 만족하는 행 출력
SELECT * 
FROM sales 
WHERE sales_amount BETWEEN 30000 AND 40000
;

SELECT * FROM customer 
WHERE customer_id BETWEEN 'C001' and 'c003';

SELECT * FROM customer 
WHERE last_name BETWEEN '가' and '아';

-- IN 연산자, 매우매우매우 자주 사용
-- OR 연산자 반복해서 쓰기 싫어서 IN 사용
SELECT * FROM sales 
WHERE product_name IN('신발', '책');