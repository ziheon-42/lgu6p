-- WEHRE절 서브쿼리
-- 서브쿼리를 잘하고 싶으면 분할 후 합치기
-- product_info 테이블에서 가전제품 카테고리만 출력하고 싶은 경우
---- 서브쿼리, 메인쿼리를 분할해서 처리해야 함
-- 서브쿼리 : 가전제품 카테고리만 조회
-- 메인쿼리 : product_info 테이블 조회

-- 가전제품 카테고리 id ==> c01
SELECT * FROM category_info;
SELECT * FROM product_info WHERE category_id = 'c01';

-- 동일하게 합치기 
SELECT category_id FROM category_info WHERE category_name = '가전제품';

SELECT * FROM product_info WHERE category_id = (
	SELECT categroy_id FROM category_info WHERE categroy_name = '악세서리'
);

-- p168
-- product_info T, event_id 컬럼의 e2에 포함된 제품의 정보만 출력
-- 메인쿼리 : product_info T 제품의 정보 출력
-- 서브쿼리 : event_id 컬럼의 e2에 해당하는 제품


SELECT * FROM product_info WHERE product_id IN('p003', 'p004', 'p005');
SELECT product_id FROM event_info WHERE event_id = 'e2'

-- 합치기
SELECT *
FROM product_info
WHERE product_id IN(
	SELECT product_id
	FROM event_info
	WHERE event_id = 'e2'
);


-- 테이블의 결합
-- LEFT JOIN RIGHT JOIN OUTER JOIN(FULL JOIN), INNER JOIN
-- LEFT OUTER JOIN, RIGHT OUTER JOIN
-- p185
SELECT *
FROM product_info pi
LEFT 
JOIN category_info ci ON pi.category_id = ci.category_id
;

-- UNION 연산자 : 테이블 아래로 붙이기
-- UNION(중복값 제거) vs UNION ALL(중복값 제거하지 않은 채 그대로 출력)
SELECT * 
FROM (
	SELECT * 
	FROM sales_2022
	UNION ALL
	SELECT *
	FROM sales_2023
	) a;

-- 서브쿼리 추가 질문
USE BikeStore;

-- 테이블
SELECT *FROM sales.orders;

-- 문제 : 2017년에 가장 많은 주문을 처리한 직원이 처리한 모든 주문 조회
---- 1. 모든 주문 정보 표시
---- 2. WHERE 서브쿼리 사용해서 2017년 최다 주문 처리 직원 찾기
---- 3. TOP1과 GROUP BY 사용
---- 4. 활용 함수: YEAR, COUNT(*) 

-- 메인 쿼리 : 모든 주문 정보 표시
SELECT *FROM sales.orders WHERE STAFF_ID = 6;

-- 서브쿼리 : 2017년에 가장 많은 주문을 처리한 직원 찾기
-- staff_id 가장 빈번하게 등장한 직원 찾기
SELECT staff_id, COUNT(*) AS 주문건수
FROM sales.orders
WHERE YEAR(order_date) = 2017
GROUP BY staff_id
;
--
SELECT TOP 1 staff_id
FROM sales.orders
WHERE YEAR(order_date) = 2017
GROUP BY staff_id
ORDER BY COUNT(*) DESC;
;

-- 합치기
SELECT *
FROM sales.orders 
WHERE STAFF_ID = (
	SELECT TOP 1 staff_id
	FROM sales.orders
	WHERE YEAR(order_date) = 2017
	GROUP BY staff_id
	ORDER BY COUNT(*) DESC
);


-- 테이블 2개
SELECT * FROM production.products;
SELECT * FROM sales.order_items;

-- 질문: 한 번도 주문되지 않은 제품들의 정보를 조회하시오
-- 중복을 제거하는 방법: SELECT DISTINCT
---- 메인 쿼리 : products 테이블의 모든 데이터를 조회
SELECT * FROM production.products;

---- 서브 쿼리 : 한 번도 주문되지 않은 제품 정보
SELECT * FROM sales.order_items;
SELECT DISTINCT product_id FROM sales.order_items; -- 주문이 최소 1번 이상은 발생한 product_id

SELECT *
FROM production.products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id FROM sales.order_items
);


-------------------------------------
-- 연습문제 --
-- 1. sales.customers 테이블에서 first_name이 'Debra'이고 last_name이 'Burks'인 고객의 모든 정보를 조회하시오.
SELECT *
FROM sales.customers
WHERE first_name = 'Debra'
AND last_name = 'Burks'
;

-- 2. sales.orders 테이블에서 2016년에 주문된 주문들의 order_id, customer_id, order_status를 조회하시오.
SELECT * FROM sales.orders;

SELECT order_id, customer_id, order_status
FROM sales.orders
WHERE YEAR(order_date) = 2016
;

-- 3. production.products 테이블에서 가격이 $500 이상이고 $1000 미만인 자전거들의 제품명과 가격을 조회하시오.
SELECT *
FROM production.products
WHERE list_price BETWEEN 500 AND 999
;

-- 4. sales.staffs 테이블에서 store_id가 2인 직원들의 이름(first_name, last_name)과 이메일을 조회하시오.
SELECT first_name, last_name, email
FROM sales.staffs
WHERE store_id = 2
;

-- 5. production.brands 테이블에서 브랜드명에 'H/h'가 포함된 브랜드들의 모든 정보를 조회하시오.


-- 6. sales.customers 테이블에서 고객의 이메일 주소에서 '@' 이전 부분만 추출하여 이름과 함께 조회하시오.
-- SUBSTRING() & CHARINDEX() 활용


-- 7. sales.orders 테이블에서 주문일(order_date)과 배송일(shipped_date) 사이의 소요 일수를 계산하시오.
-- DATEDIFF(), ISNULL(), GETDATE() 활용


-- 8. sales.orders 테이블에서 주문 상태(order_status)를 다음과 같이 변환하여 조회하시오:
-- 1: 'Pending', 2: 'Processing', 3: 'Rejected', 4: 'Completed', ELSE 'Unknown'
-- CASE WHEN 활용


-- 9. sales.customers 테이블에서 phone이 NULL인 경우 'No Phone'으로 표시하여 조회하시오.
-- ISNULL() 활용


-- 10. production.products 테이블에서 제품명이 NULL이 아니고 가격이 0보다 큰 제품들만 조회하시오.