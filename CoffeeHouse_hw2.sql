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
----почему-то даты не хотели сравниваться - пришлось выполнить 
----дополнительную конвертацию в VARCHAR(10)
SELECT *
    FROM ch_orders
    WHERE CAST(TO_DATE('25.04.2021') AS VARCHAR(10))=
                CAST(CAST(created_on AS DATE) AS VARCHAR(10))
        AND deleted='N';
--Показать информацию о заказах в указанном промежутке дат
SELECT *
    FROM ch_orders
    WHERE created_on BETWEEN TO_DATE('18.04.2021') AND TO_DATE('30.04.2021')
        AND deleted='N';
--Показать количество заказов десертов в конкретную дату
----учитывается только количество видов десертов (без учёта количества порций)
SELECT COUNT(*)
    FROM ch_orders o
        LEFT JOIN ch_order_details od ON od.order_id=o.id
        LEFT JOIN ch_goods g ON g.id=od.product_id
    WHERE CAST(TO_DATE('25.04.2021') AS VARCHAR(10))=
                CAST(CAST(o.created_on AS DATE) AS VARCHAR(10))
        AND g.category_id=1
        AND od.deleted='N';
----количество порций всех видов десертов
SELECT SUM(od.quantity)
    FROM ch_orders o
        LEFT JOIN ch_order_details od ON od.order_id=o.id
        LEFT JOIN ch_goods g ON g.id=od.product_id
    WHERE CAST(TO_DATE('25.04.2021') AS VARCHAR(10))=
                CAST(CAST(o.created_on AS DATE) AS VARCHAR(10))
        AND g.category_id=1
        AND od.deleted='N';
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
