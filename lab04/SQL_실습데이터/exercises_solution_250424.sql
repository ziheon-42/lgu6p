USE BikeStores;

-- 1. sales.customers 테이블에서 first_name이 'Debra'이고 last_name이 'Burks'인 고객의 모든 정보를 조회하시오.
SELECT *
FROM sales.customers
WHERE first_name = 'Debra' AND last_name = 'Burks';

-- 2. sales.orders 테이블에서 2016년에 주문된 주문들의 order_id, customer_id, order_status를 조회하시오.
SELECT order_id, customer_id, order_status
FROM sales.orders 
WHERE YEAR(order_date) = 2016;

-- 3. production.products 테이블에서 가격이 $500 이상이고 $1000 미만인 자전거들의 제품명과 가격을 조회하시오.
SELECT product_name, list_price
FROM production.products
WHERE list_price >= 500 AND list_price < 1000;

-- 4. sales.staffs 테이블에서 store_id가 2인 직원들의 이름(first_name, last_name)과 이메일을 조회하시오.
SELECT first_name, last_name, email
FROM sales.staffs
WHERE store_id = 2;

-- 5. production.brands 테이블에서 브랜드명에 'H/h'가 포함된 브랜드들의 모든 정보를 조회하시오.
SELECT *
FROM production.brands
WHERE brand_name LIKE '%H%';

-- 6. sales.customers 테이블에서 고객의 이메일 주소에서 '@' 이전 부분만 추출하여 이름과 함께 조회하시오.
-- SUBSTRING() & CHARINDEX() 활용
SELECT first_name, last_name, SUBSTRING(email, 1, CHARINDEX('@', email) - 1) AS email_id
FROM sales.customers;

-- 7. sales.orders 테이블에서 주문일(order_date)과 배송일(shipped_date) 사이의 소요 일수를 계산하시오.
-- DATEDIFF(), ISNULL(), GETDATE() 활용
SELECT order_id, order_date, shipped_date, 
       DATEDIFF(day, order_date, ISNULL(shipped_date, GETDATE())) AS days_to_ship
FROM sales.orders;

-- 8. sales.orders 테이블에서 주문 상태(order_status)를 다음과 같이 변환하여 조회하시오:
-- 1: 'Pending', 2: 'Processing', 3: 'Rejected', 4: 'Completed', ELSE 'Unknown'
-- CASE WHEN 활용
SELECT order_id, 
       CASE order_status
           WHEN 1 THEN 'Pending'
           WHEN 2 THEN 'Processing'
           WHEN 3 THEN 'Rejected'
           WHEN 4 THEN 'Completed'
           ELSE 'Unknown'
       END AS status_description
FROM sales.orders;

-- 9. sales.customers 테이블에서 phone이 NULL인 경우 'No Phone'으로 표시하여 조회하시오.
-- ISNULL() 활용
SELECT customer_id, first_name, last_name, 
       ISNULL(phone, 'No Phone') AS contact_number
FROM sales.customers;

-- 10. production.products 테이블에서 제품명이 NULL이 아니고 가격이 0보다 큰 제품들만 조회하시오.
SELECT product_id, product_name, list_price
FROM production.products
WHERE product_name IS NOT NULL 
AND list_price > 0;



