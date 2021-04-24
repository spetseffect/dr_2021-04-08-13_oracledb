ALTER SESSION SET
    NLS_DATE_LANGUAGE = RUSSIAN
    NLS_DATE_FORMAT = 'DD.MM.YYYY'
    NLS_TIME_FORMAT = 'HH24:MI:SS'
    NLS_TIMESTAMP_FORMAT = 'DD.MM.YYYY HH24:MI:SS';
CREATE SEQUENCE seq_ch_orders
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
----
--���������� ���������� � ����� ������ ����
INSERT INTO ch_orders(id,created_on,closed_on,employee_id,client_id,discount,total_sum) VALUES
    (seq_ch_orders.nextval
    ,SYSDATE
    ,SYSDATE
    ,1
    ,1
    ,(SELECT discount FROM ch_clients WHERE id=1)
    ,0);
INSERT INTO ch_order_details(order_id,product_id,price,quantity) VALUES
    (seq_ch_orders.currval
    ,1
    ,(SELECT price FROM ch_goods WHERE id=1)
    ,2);
DECLARE sid INT;
BEGIN
    sid:=seq_ch_orders.currval;
    UPDATE ch_orders o
        SET o.total_sum=(SELECT SUM(price*quantity) "sum" 
                            FROM ch_order_details 
                            WHERE order_id=o.id)
        WHERE o.id=sid;
END;
--���������� ���������� � ����� ������ �������
INSERT INTO ch_orders(id,created_on,closed_on,employee_id,client_id,discount,total_sum) VALUES
    (seq_ch_orders.nextval
    ,SYSDATE
    ,SYSDATE
    ,5
    ,2
    ,(SELECT discount FROM ch_clients WHERE id=2)
    ,0);
INSERT INTO ch_order_details(order_id,product_id,price,quantity) VALUES
    (seq_ch_orders.currval
    ,6
    ,(SELECT price FROM ch_goods WHERE id=6)
    ,1);
INSERT INTO ch_order_details(order_id,product_id,price,quantity) VALUES
    (seq_ch_orders.currval
    ,8
    ,(SELECT price FROM ch_goods WHERE id=8)
    ,1);
DECLARE sid INT;
BEGIN
    sid:=seq_ch_orders.currval;
    UPDATE ch_orders o
        SET o.total_sum=(SELECT SUM(price*quantity) "sum"
                            FROM ch_order_details 
                            WHERE order_id=o.id)
        WHERE o.id=sid;
END;
--���������� ���������� � ������� ������ � ��������� �����������
----��������� ����������� - ��������
INSERT INTO ch_holidays(target_date) VALUES (NEXT_DAY(SYSDATE, '�����������'));
--���������� ���������� � ����� ���� ����
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('������','Butriak',2,20.10);
--�������� ���������� ������ �� ��������� �������
----��������� ������� ���� �� 1 ��� ����� � 1 ��� �������. 
----������� ��������� ����� ������������ ��������� �������
INSERT INTO ch_holidays(target_date,begintime,endtime) VALUES 
    (NEXT_DAY(SYSDATE, '�������'),'08:00','09:00');
INSERT INTO ch_holidays(target_date,begintime,endtime) VALUES 
    (NEXT_DAY(SYSDATE, '�������'),'18:00','19:00');
--�������� �������� ��� ������������� ���� ����
UPDATE ch_goods
    SET name_ru='����� ��������',
        name_en='Swamp Bzdysh'
    WHERE id=4;
--�������� ���������� � ������������ ������
UPDATE ch_order_details
    SET quantity=3
    WHERE order_id=2
        AND product_id=8;
UPDATE ch_orders o
    SET o.total_sum=(SELECT SUM(price*quantity) "sum"
                        FROM ch_order_details 
                        WHERE order_id=o.id)
    WHERE o.id=2;
--�������� �������� ��� ������������� �������
UPDATE ch_goods
    SET name_ru='��������� �������',
        name_en='Golden Burdylka'
    WHERE id=8;
--������� ���������� �����

--������� ������ ����������� �������

--������� ���������� ������ �� ���������� ����

--������� ���������� ������ �� ���������� ���������� ����� ���������� ������

--�������� ��� ������ ����������� �������

--�������� ���������� ������ �� ���������� ����

--�������� ��� ������ ����������� ���������

--�������� ��� ������ ����������� �������

--������� 5
--�������� � ���������� ������� ��������� ����������������:
--���������� ������;
--�������� ������;
--���������� ������