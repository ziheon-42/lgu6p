-- Chapter 9�� 
-- �ǽ� ������ �Ұ� 
USE lily_book_testdb;

-- ���̺� Ȯ�� 
SELECT * FROM sales2;
SELECT * FROM customer;

/***********************************************************
�� ���� Ʈ���� (p.203)
************************************************************/

-- �Ⱓ�� ���� ��Ȳ
-- ��� �÷� : invoicedate, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����
-- Ȱ�� �Լ� : SUM(), COUNT()
SELECT 
	invoicedate
	, SUM(unitprice*quantity) AS �����
	, SUM(quantity) AS �ֹ�����
FROM sales2
GROUP BY invoicedate
ORDER BY invoicedate
;


-- ������ ���� ��Ȳ
-- ��� �÷� : country, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����
-- Ȱ�� �Լ� : SUM(), COUNT()
SELECT 
	country
	, stockcode
	, SUM(unitprice*quantity) AS �����
	, SUM(quantity) AS �ֹ�����
FROM sales
GROUP BY country, stockcode
;

-- ������ x ��ǰ�� ���� ��Ȳ 
-- ��� �÷� : country, stockcode, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����
-- Ȱ�� �Լ� : SUM(), COUNT()


-- Ư�� ��ǰ ���� ��Ȳ
-- ��� �÷� : �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����
-- Ȱ�� �Լ� : SUM(), COUNT()
-- �ڵ�� : 21615
SELECT 
	ROUND(SUM(unitprice*quantity), 2) AS �����
FROM sales
WHERE stockcode = '21615';



-- Ư�� ��ǰ�� �Ⱓ�� ���� ��Ȳ 
-- ��� �÷� : invoicedate, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����
-- Ȱ�� �Լ� : SUM(), COUNT()
-- �ڵ�� : 21615, 21731


/***********************************************************
�� �̺�Ʈ ȿ�� �м� (p.213)
************************************************************/

-- �̺�Ʈ ȿ�� �м� (�ñ⿡ ���� ��)
-- 2011�� 9/10 ~ 2011�� 9/25���� �� 15�ϵ��� ������ �̺�Ʈ�� ���� Ȯ�� 
-- ��� �÷� : �Ⱓ ����, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ����� 
-- Ȱ�� �Լ� : CASE WHEN, SUM(), COUNT()
-- �Ⱓ ���� �÷��� ���� ���� : �̺�Ʈ �Ⱓ, �̺�Ʈ �񱳱Ⱓ(�������Ⱓ)
SELECT 
    CASE 
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-09-10' AND '2011-09-25' THEN '�̺�Ʈ �Ⱓ'
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-08-10' AND '2011-08-25' THEN '�񱳱Ⱓ'
        ELSE '��Ÿ'
    END AS �Ⱓ����
	, SUM(unitprice*quantity) AS �����
FROM sales
GROUP BY CASE 
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-09-10' AND '2011-09-25' THEN '�̺�Ʈ �Ⱓ'
        WHEN CONVERT(DATE, invoicedate) BETWEEN '2011-08-10' AND '2011-08-25' THEN '�񱳱Ⱓ'
        ELSE '��Ÿ'
    END
;





-- �̺�Ʈ ȿ�� �м� (�ñ⿡ ���� ��)
-- 2011�� 9/10 ~ 2011�� 9/25���� Ư�� ��ǰ�� �ǽ��� �̺�Ʈ�� ���� ���� Ȯ��
-- ��� �÷� : �Ⱓ ����, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ����� 
-- Ȱ�� �Լ� : CASE WHEN, SUM(), COUNT()
-- �Ⱓ ���� �÷��� ���� ���� : �̺�Ʈ �Ⱓ, �̺�Ʈ �񱳱Ⱓ(�������Ⱓ)
-- ��ǰ�� : 17012A, 17012C, 17084N


/***********************************************************
�� CRM �� Ÿ�� ��� (p.217)
************************************************************/

-- Ư�� ��ǰ ���� �� ����
-- ���� : 2010.12.1 - 2010.12.10�ϱ��� Ư�� ��ǰ ������ �� ���� ���
-- ��� �÷� : �� ID, �̸�, ����, �������, ���� ����, ���, ���� ä��
-- HINT : �ζ��� �� ��������, LEFT JOIN Ȱ��
-- Ȱ���Լ� : CONCAT()
-- �ڵ�� : 21730, 21615

SELECT * 
FROM (
	SELECT DISTINCT customerid
	FROM sales
	WHERE stockcode IN ('21730', '21615')
		AND CONVERT(DATE, invoicedate) BETWEEN '2010-12-01' AND '2010-12-18'
	) s
LEFT 
JOIN (
	SELECT 
		mem_no
		, CONCAT(last_name, first_name) AS customer_name
		, gd
		, birth_dt
		, entr_dt
		, grade 
		, sign_up_ch
	FROM customer	
) c
ON s.customerid = c.mem_no
;


-- �̱��� �� ���� Ȯ��
-- ���� : ��ü ����� ���� �� �߿��� ���� �̷��� ���� ���� ���� �̷��� �ִ� �� ���� ���� 
-- ��� �÷� : non_purchaser, mem_no, last_name, first_name, invoiceno, stockcode, invoicedate, unitprice, customerid
-- HINT : LEFT JOIN
-- Ȱ���Լ� : CASE WHEN, IS NULL, 

-- ��ü ������ �̱��� ���� ��� 
-- ��� �÷� : non_purchaser, total_customer
-- HINT : LEFT JOIN
-- Ȱ�� �Լ� : COUNT(), IS NULL


/***********************************************************
�� �� ��ǰ ���� ���� (p.227)
************************************************************/

-- ���� ��� ��ǥ Ȱ���ϱ� 
-- ���� �����ǥ ���� : ATV, AMV, Avg.Frq, Avg.Units
-- ���� : sales �������� ���� �����ǥ, ATV, AMV, Avg.Frq, Avg.Units �˰� ����
-- ��� �÷� : �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����, ATV, AMV, Avg.Frq, Avg.Units
-- Ȱ���Լ� : SUM(), COUNT()

-- ���� : ���� : ���� �� ���� ���� �����ǥ, ATV, AMV, Avg.Frq, Avg.Units �˰� ����
-- ��� �÷� : ����, ��, �����, �ֹ�����, �ֹ��Ǽ�, �ֹ�����, ATV, AMV, Avg.Frq, Avg.Units
-- Ȱ���Լ� : SUM(), COUNT(), YEAR, MONTH
SELECT 
	YEAR(invoicedate) AS ���� 
FROM sales
;

/***********************************************************
�� �� ��ǰ ���� ���� (p.230)
************************************************************/

-- Ư�� ���� ����Ʈ���� ��ǰ Ȯ��
-- ���� : 2011�⿡ ���� ���� �Ǹŵ� ��ǰ TOP 10�� ���� Ȯ�� 
-- ��� �÷� : stockcode, description, qty
-- Ȱ���Լ� : TOP 10, SUM(), YEAR()
SELECT TOP 10
	stockcode 
	, CONVERT(VARCHAR(255), description) AS description
	, SUM(quantity) as qty 
FROM sales 
WHERE YEAR(invoicedate) = '2011'
GROUP BY stockcode, CONVERT(VARCHAR(255), description)
ORDER BY qty DESC
;



-- ������ ����Ʈ���� ��ǰ Ȯ��
-- ���� : �������� ���� ���� �Ǹŵ� ��ǰ ������ ������ ���ϰ� ����
-- ��� �÷� : RNK, country, stockcode, description, qty
-- HINT : �ζ��� �� ��������
-- Ȱ���Լ� : ROW_NUMBER() OVER(PARTITION BY...), SUM()
SELECT 
	ROW_NUMBER() OVER(PARTITION BY country ORDER BY qty DESC) as rnk
	, a.*
FROM (
	SELECT 
		country
		, stockcode 
		, CONVERT(VARCHAR(255), description) AS description
		, SUM(quantity) as qty 
	FROM sales 
	WHERE YEAR(invoicedate) = '2011'
	GROUP BY country, stockcode, CONVERT(VARCHAR(255), description)
) a
ORDER BY 2, 1
;

-- 20�� ���� ���� ����Ʈ���� ��ǰ Ȯ�� 
-- ���� : 20�� ���� ���� ���� ���� ������ TOP 10�� ���� Ȯ�� 
-- ��� �÷� : RNK, country, stockcode, description, qty
-- HINT : �ζ��� �� ��������, �ζ��� �� �������� �ۼ� ��, LEFT JOIN �ʿ�
-- Ȱ���Լ� : ROW_NUMBER() OVER(PARTITION BY...), SUM(), YEAR()

/***********************************************************
�� �� ��ǰ ���� ���� (p.238)
************************************************************/

-- Ư�� ��ǰ�� �Բ� ���� ���� ������ ��ǰ Ȯ�� 
-- ���� : Ư�� ��ǰ(stockcode='20725')�� �Բ� ���� ���� ������ TOP 10�� ���� Ȯ��
-- ��� �÷� : stockcode, description, qty 
-- HINT : INNER JOIN
-- Ȱ���Լ� : SUM()

-- �� �ڵ忡��, ��ǰ�� LUNCH�� ���Ե� ��ǰ�� ���� 
SELECT TOP 10
	s.stockcode
	, CONVERT(VARCHAR(255), s.description)
	, SUM(quantity) as qty 
FROM sales s 
INNER 
JOIN (
	SELECT DISTINCT invoiceno 
	FROM sales 
	WHERE stockcode = '20725'
) i
ON s.invoiceno = i.invoiceno
WHERE s.stockcode <> '20725'
	AND CONVERT(VARCHAR(255), s.description) NOT LIKE '%LUNCH%'
GROUP BY s.stockcode, CONVERT(VARCHAR(255), s.description)
ORDER BY qty DESC 

/***********************************************************
�� �� ��ǰ ���� ���� (p.244)
************************************************************/

-- �籸�� ���� ���� Ȯ��
-- ��� 1 : ������ ������ �� ���� ���
-- ���� : ���θ��� �籸�� ���� Ȯ�� 
-- ��� �÷� : repurchaser_count
-- HINT : �ζ��� ��
-- Ȱ�� �Լ� : COUNT()



-- ��� 2 : ������ ������ �ϼ��� ������ �ű�� ���
-- ���� : ���θ��� �籸�� ���� Ȯ�� 
-- ��� �÷� : repurchaser_count
-- HINT : �ζ��� ��
-- Ȱ�� �Լ� : COUNT(), DENSE_RANK() OVER(PARTITION BY...)


-- ���ټ� �� ��ȣƮ �м�
-- 2010�� ���� �̷��� �ִ� 2011�� ������ Ȯ�� 
SELECT COUNT(DISTINCT customerid) AS rentention_cnt
FROM sales
WHERE customerid <> ''
	AND customerid IN (
	SELECT DISTINCT customerid FROM sales 
	WHERE customerid <> ''
		AND YEAR(invoicedate) = '2010'
)
	AND YEAR(invoicedate) = '2011'
;

SELECT 
	customerid 
	, invoicedate 
	, DENSE_RANK() OVER(PARTITION BY customerid ORDER BY invoicedate) AS day_no 
FROM (
	SELECT customerid, invoicedate 
	FROM sales 
	WHERE customerid <> ''
	GROUP BY customerid, invoicedate
) a
;
