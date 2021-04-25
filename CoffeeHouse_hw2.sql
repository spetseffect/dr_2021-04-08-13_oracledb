ALTER SESSION SET
    NLS_DATE_LANGUAGE = RUSSIAN
    NLS_DATE_FORMAT = 'DD.MM.YYYY'
    NLS_TIME_FORMAT = 'HH24:MI:SS'
    NLS_TIMESTAMP_FORMAT = 'DD.MM.YYYY HH24:MI:SS';
----
--Показать минимальную скидку для клиента
SELECT MIN(discount) FROM ch_clients WHERE deleted='N';
--Показать максимальную скидку для клиента
SELECT MAX(discount) FROM ch_clients WHERE deleted='N';
--Показать клиентов с минимальной скидкой и величину скидки
SELECT c.id, c.full_name, c.discount
    FROM ch_clients c
    WHERE c.discount=(SELECT MIN(discount) FROM ch_clients WHERE deleted='N')
        AND c.deleted='N';
--Показать клиентов с максимальной скидкой и величину скидки
SELECT c.id, c.full_name, c.discount
    FROM ch_clients c
    WHERE c.discount=(SELECT MAX(discount) FROM ch_clients WHERE deleted='N')
        AND c.deleted='N';
--Показать среднюю величину скидки
SELECT AVG(discount) FROM ch_clients WHERE deleted='N';
--Показать самого молодого клиента
SELECT c.id
        ,c.full_name
        ,c.birthday
        ,EXTRACT(YEAR FROM (SYSDATE-c.birthday) YEAR TO MONTH) "AGE"
        ,c.discount
    FROM ch_clients c
    WHERE c.birthday=(SELECT MAX(birthday) FROM ch_clients WHERE deleted='N');
--Показать самого возрастного клиента
SELECT c.id
        ,c.full_name
        ,c.birthday
        ,EXTRACT(YEAR FROM (SYSDATE-c.birthday) YEAR TO MONTH) "AGE"
        ,c.discount
    FROM ch_clients c
    WHERE c.birthday=(SELECT MIN(birthday) FROM ch_clients WHERE deleted='N');
--Показать клиентов, у которых день рождения в этот день
SELECT c.id
        ,c.full_name
        ,c.birthday
        ,EXTRACT(YEAR FROM (SYSDATE-c.birthday) YEAR TO MONTH) "AGE"
        ,c.discount
    FROM ch_clients c
    WHERE EXTRACT(MONTH FROM c.birthday)=EXTRACT(MONTH FROM SYSDATE)
        AND EXTRACT(DAY FROM c.birthday)=EXTRACT(DAY FROM SYSDATE)
        AND c.deleted='N';
--Показать клиентов, у которых не заполнен контактный почтовый адрес
SELECT * 
    FROM ch_clients
    WHERE address IS NULL;
--Показать информацию о заказах в конкретную дату

--Показать информацию о заказах в указанном промежутке дат

--Показать количество заказов десертов в конкретную дату

--Показать количество заказов напитков в конкретную дату

--Показать информацию о клиентах, которые заказывали напитки сегодня.
---Кроме информации о клиенте, нужно показывать информацию о бариста,
---который сделал напиток

--Показать среднюю сумму заказа в конкретную дату

--Показать максимальную сумму заказа в конкретную дату

--Показать клиента, который совершил максимальную сумму заказа в конкретную дату

--Показать расписание работы конкретного бариста на неделю
----в текущей БД график работы задан для всей кофейни, 
----соответственно у всех работников одинаковый график
