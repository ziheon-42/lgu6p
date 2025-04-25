-- ���� WHERE��
-- ���ǰ� ��ġ�ϴ� ������ ��ȸ(���͸�)
-- pandas, iloc, loc, �񱳿����� �� ���� ���
-- 94p
-- ���� ���� ���͸� �� id, name, gender�� ���
USE lily_book;

-- [!] ���� ����. "" �ȵ�. ''�� ����
SELECT 
	*
FROM
	dbo.customer
WHERE customer_id = 'c002'
;

-- WHERER�� �ȿ��� �񱳿����� ���ؼ� ���͸�
-- <>, != : �¿� ���� ���� ���� ����
SELECT * FROM sales;

-- sales_amount�� ���� ����� �͸� ��ȸ
SELECT * FROM sales
WHERE sales_amount > 0;

-- ���ڸ� �Է��� �� �ٻ��ϰ� �Է��غ���
SELECT * FROM sales WHERE sales_amount = 41000;

-- �����Ͱ� �ƿ� ���� ���� NULL ���·� ���
-- ��ȸ�� �� ��, ��Ȯ�ϰ� �Է����� �ʾƵ� NULL ���·� ���
---- 41000�� ���ٰ� ERROR�� ���� ���� �ƴ϶� NULL ���·� ��µ�
SELECT * FROM customer WHERE customer_id = 'Z002';

-- BETWEEN ������(���� ����)_100p
-- 30000�� 40000 ������ ������ �����ϴ� �� ���
SELECT * 
FROM sales 
WHERE sales_amount BETWEEN 30000 AND 40000
;

SELECT * FROM customer 
WHERE customer_id BETWEEN 'C001' and 'c003';

SELECT * FROM customer 
WHERE last_name BETWEEN '��' and '��';

-- IN ������, �ſ�ſ�ſ� ���� ���
-- OR ������ �ݺ��ؼ� ���� �Ⱦ IN ���
SELECT * FROM sales 
WHERE product_name IN('�Ź�', 'å');