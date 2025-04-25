-- WEHRE�� ��������
-- ���������� ���ϰ� ������ ���� �� ��ġ��
-- product_info ���̺��� ������ǰ ī�װ��� ����ϰ� ���� ���
---- ��������, ���������� �����ؼ� ó���ؾ� ��
-- �������� : ������ǰ ī�װ��� ��ȸ
-- �������� : product_info ���̺� ��ȸ

-- ������ǰ ī�װ� id ==> c01
SELECT * FROM category_info;
SELECT * FROM product_info WHERE category_id = 'c01';

-- �����ϰ� ��ġ�� 
SELECT category_id FROM category_info WHERE category_name = '������ǰ';

SELECT * FROM product_info WHERE category_id = (
	SELECT categroy_id FROM category_info WHERE categroy_name = '�Ǽ�����'
);

-- p168
-- product_info T, event_id �÷��� e2�� ���Ե� ��ǰ�� ������ ���
-- �������� : product_info T ��ǰ�� ���� ���
-- �������� : event_id �÷��� e2�� �ش��ϴ� ��ǰ


SELECT * FROM product_info WHERE product_id IN('p003', 'p004', 'p005');
SELECT product_id FROM event_info WHERE event_id = 'e2'

-- ��ġ��
SELECT *
FROM product_info
WHERE product_id IN(
	SELECT product_id
	FROM event_info
	WHERE event_id = 'e2'
);


-- ���̺��� ����
-- LEFT JOIN RIGHT JOIN OUTER JOIN(FULL JOIN), INNER JOIN
-- LEFT OUTER JOIN, RIGHT OUTER JOIN
-- p185
SELECT *
FROM product_info pi
LEFT 
JOIN category_info ci ON pi.category_id = ci.category_id
;

-- UNION ������ : ���̺� �Ʒ��� ���̱�
-- UNION(�ߺ��� ����) vs UNION ALL(�ߺ��� �������� ���� ä �״�� ���)
SELECT * 
FROM (
	SELECT * 
	FROM sales_2022
	UNION ALL
	SELECT *
	FROM sales_2023
	) a;

-- �������� �߰� ����
USE BikeStore;

-- ���̺�
SELECT *FROM sales.orders;

-- ���� : 2017�⿡ ���� ���� �ֹ��� ó���� ������ ó���� ��� �ֹ� ��ȸ
---- 1. ��� �ֹ� ���� ǥ��
---- 2. WHERE �������� ����ؼ� 2017�� �ִ� �ֹ� ó�� ���� ã��
---- 3. TOP1�� GROUP BY ���
---- 4. Ȱ�� �Լ�: YEAR, COUNT(*) 

-- ���� ���� : ��� �ֹ� ���� ǥ��
SELECT *FROM sales.orders WHERE STAFF_ID = 6;

-- �������� : 2017�⿡ ���� ���� �ֹ��� ó���� ���� ã��
-- staff_id ���� ����ϰ� ������ ���� ã��
SELECT staff_id, COUNT(*) AS �ֹ��Ǽ�
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

-- ��ġ��
SELECT *
FROM sales.orders 
WHERE STAFF_ID = (
	SELECT TOP 1 staff_id
	FROM sales.orders
	WHERE YEAR(order_date) = 2017
	GROUP BY staff_id
	ORDER BY COUNT(*) DESC
);


-- ���̺� 2��
SELECT * FROM production.products;
SELECT * FROM sales.order_items;

-- ����: �� ���� �ֹ����� ���� ��ǰ���� ������ ��ȸ�Ͻÿ�
-- �ߺ��� �����ϴ� ���: SELECT DISTINCT
---- ���� ���� : products ���̺��� ��� �����͸� ��ȸ
SELECT * FROM production.products;

---- ���� ���� : �� ���� �ֹ����� ���� ��ǰ ����
SELECT * FROM sales.order_items;
SELECT DISTINCT product_id FROM sales.order_items; -- �ֹ��� �ּ� 1�� �̻��� �߻��� product_id

SELECT *
FROM production.products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id FROM sales.order_items
);


-------------------------------------
-- �������� --
-- 1. sales.customers ���̺��� first_name�� 'Debra'�̰� last_name�� 'Burks'�� ���� ��� ������ ��ȸ�Ͻÿ�.
SELECT *
FROM sales.customers
WHERE first_name = 'Debra'
AND last_name = 'Burks'
;

-- 2. sales.orders ���̺��� 2016�⿡ �ֹ��� �ֹ����� order_id, customer_id, order_status�� ��ȸ�Ͻÿ�.
SELECT * FROM sales.orders;

SELECT order_id, customer_id, order_status
FROM sales.orders
WHERE YEAR(order_date) = 2016
;

-- 3. production.products ���̺��� ������ $500 �̻��̰� $1000 �̸��� �����ŵ��� ��ǰ��� ������ ��ȸ�Ͻÿ�.
SELECT *
FROM production.products
WHERE list_price BETWEEN 500 AND 999
;

-- 4. sales.staffs ���̺��� store_id�� 2�� �������� �̸�(first_name, last_name)�� �̸����� ��ȸ�Ͻÿ�.
SELECT first_name, last_name, email
FROM sales.staffs
WHERE store_id = 2
;

-- 5. production.brands ���̺��� �귣��� 'H/h'�� ���Ե� �귣����� ��� ������ ��ȸ�Ͻÿ�.


-- 6. sales.customers ���̺��� ���� �̸��� �ּҿ��� '@' ���� �κи� �����Ͽ� �̸��� �Բ� ��ȸ�Ͻÿ�.
-- SUBSTRING() & CHARINDEX() Ȱ��


-- 7. sales.orders ���̺��� �ֹ���(order_date)�� �����(shipped_date) ������ �ҿ� �ϼ��� ����Ͻÿ�.
-- DATEDIFF(), ISNULL(), GETDATE() Ȱ��


-- 8. sales.orders ���̺��� �ֹ� ����(order_status)�� ������ ���� ��ȯ�Ͽ� ��ȸ�Ͻÿ�:
-- 1: 'Pending', 2: 'Processing', 3: 'Rejected', 4: 'Completed', ELSE 'Unknown'
-- CASE WHEN Ȱ��


-- 9. sales.customers ���̺��� phone�� NULL�� ��� 'No Phone'���� ǥ���Ͽ� ��ȸ�Ͻÿ�.
-- ISNULL() Ȱ��


-- 10. production.products ���̺��� ��ǰ���� NULL�� �ƴϰ� ������ 0���� ū ��ǰ�鸸 ��ȸ�Ͻÿ�.