ALTER SESSION SET
    NLS_DATE_LANGUAGE = RUSSIAN
    NLS_DATE_FORMAT = 'DD.MM.YYYY'
    NLS_TIME_FORMAT = 'HH24:MI:SS'
    NLS_TIMESTAMP_FORMAT = 'DD.MM.YYYY HH24:MI:SS';
----
--Показать минимальную скидку для клиента
SELECT MIN(discount) FROM ch_clients;
--Показать максимальную скидку для клиента
SELECT MAX(discount) FROM ch_clients;
--Показать клиентов с минимальной скидкой и величину скидки
SELECT c.id, c.full_name, c.discount
    FROM ch_clients c
    WHERE c.discount=(SELECT MIN(discount) FROM ch_clients);
--Показать клиентов с максимальной скидкой и величину скидки
SELECT c.id, c.full_name, c.discount
    FROM ch_clients c
    WHERE c.discount=(SELECT MAX(discount) FROM ch_clients);
--Показать среднюю величину скидки
SELECT AVG(discount) FROM ch_clients;
--Показать самого молодого клиента
SELECT c.id
        ,c.full_name
        ,c.birthday
        ,EXTRACT(YEAR FROM (SYSDATE-c.birthday) YEAR TO MONTH) "AGE"
        ,c.discount
    FROM ch_clients c
    WHERE c.birthday=(SELECT MAX(birthday) FROM ch_clients);
--Показать самого возрастного клиента

--Показать клиентов, у которых день рождения в этот день

--Показать клиентов, у которых не заполнен контактный почтовый адрес

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
