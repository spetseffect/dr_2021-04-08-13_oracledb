--�������� ���� �� ������������ ��� ����
UPDATE ch_goods 
    SET price=10.50
    WHERE id=1;
--�������� ����������, �������� ����� ���������
UPDATE ch_employees
    SET email='popr1@ch.ua'
    WHERE id=6;
--�������� ���������� ������� �������
SELECT phone1, phone2
    FROM ch_employees
    WHERE position_id=1;
--�������� ������� ������ ����������� �������
UPDATE ch_clients
    SET discount=1
    WHERE id=4;
--������� ���������� � ���������� �������
UPDATE ch_goods
    SET deleted='Y'
    WHERE id=7;
--������� ���������� �� ������������ ���������
UPDATE ch_employees
    SET deleted='Y'
    WHERE id=3;
--������� ���������� �� ������������ �������
UPDATE ch_employees
    SET deleted='Y'
    WHERE id=2;
--������� ���������� � ���������� �������
UPDATE ch_clients
    SET deleted='Y'
    WHERE id=4;
--�������� ��� �������
SELECT *
    FROM ch_goods
    WHERE category_id=2;
--�������� ��� �������
SELECT *
    FROM ch_goods
    WHERE category_id=1;
--�������� ���������� ��� ���� �������
SELECT *
    FROM ch_employees
    WHERE position_id=1;
--�������� ���������� ��� ���� ����������
SELECT *
    FROM ch_employees
    WHERE position_id=2;