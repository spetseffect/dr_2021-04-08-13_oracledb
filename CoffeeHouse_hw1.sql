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
--Добавление информации о новом заказе кофе
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
                            WHERE order_id=o.id)*(1-o.discount/100)
        WHERE o.id=sid;
END;
--Добавление информации о новом заказе десерта
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
                            WHERE order_id=o.id)*(1-o.discount/100)
        WHERE o.id=sid;
END;
--Добавление информации о графике работы в ближайший понедельник
----ближайший понедельник - выходной
INSERT INTO ch_holidays(target_date_begin,target_date_end) VALUES 
    (NEXT_DAY(SYSDATE, 'Понедельник'),NEXT_DAY(SYSDATE, 'Понедельник'));
--Добавление информации о новом виде кофе
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('Бутряк','Butriak',2,20.10);
--Изменить расписание работы на ближайший вторник
----сократить рабочий день на 1 час утром и 1 час вечером. 
----указать нерабочее время относительно основного графика
INSERT INTO ch_holidays(target_date_begin,target_date_end,begintime,endtime) VALUES 
    (NEXT_DAY(SYSDATE, 'вторник'),NEXT_DAY(SYSDATE, 'Вторник'),'08:00','09:00');
INSERT INTO ch_holidays(target_date_begin,target_date_end,begintime,endtime) VALUES 
    (NEXT_DAY(SYSDATE, 'вторник'),NEXT_DAY(SYSDATE, 'Вторник'),'18:00','19:00');
--Изменить название уже существующего вида кофе
UPDATE ch_goods
    SET name_ru='Бздыш Болотный',
        name_en='Swamp Bzdysh'
    WHERE id=4;
--Изменить информацию в существующем заказе
UPDATE ch_order_details
    SET quantity=3
    WHERE order_id=2
        AND product_id=8;
UPDATE ch_orders o
    SET o.total_sum=(SELECT SUM(price*quantity) "sum"
                        FROM ch_order_details 
                        WHERE order_id=o.id)*(1-o.discount/100)
    WHERE o.id=2;
--Изменить название уже существующего десерта
UPDATE ch_goods
    SET name_ru='Бурдылька Золотая',
        name_en='Golden Burdylka'
    WHERE id=8;
--Удалить конкретный заказ
UPDATE ch_orders
    SET deleted='Y'
    WHERE id=1;
UPDATE ch_order_details
    SET deleted='Y'
    WHERE order_id=1;
--Удалить заказы конкретного десерта
----корректировка задания: Удалить заказы в которых присутствует конкретный десерт
UPDATE ch_orders
    SET deleted='Y'
    WHERE id IN (SELECT order_id
                    FROM ch_order_details
                    WHERE product_id=5);
UPDATE ch_order_details
    SET deleted='Y'
    WHERE order_id IN (SELECT order_id
                    FROM ch_order_details
                    WHERE product_id=5);                    
--Удалите расписание работы на конкретный день
----сделать выходной в воскресенье на постоянной основе
DELETE FROM ch_shedules_static
    WHERE weekday='Воскресенье';
--Удалите расписание работы на конкретный промежуток между указанными датами
----выходные на конкретный промежуток между указанными датами
INSERT INTO ch_holidays(target_date_begin,target_date_end) VALUES 
    (TO_DATE('30.04.2021'),TO_DATE('10.05.2021'));
--Показать все заказы конкретного десерта
----заказы в которых присутствует конкретный десерт, в том числе удалённые
SELECT o.*
    FROM ch_orders o
        LEFT JOIN ch_order_details od ON od.order_id=o.id
    WHERE od.product_id=5;
--Показать расписание работы на конкретный день
SELECT *
    FROM ch_shedules_static
    WHERE weekday='Пятница';
--Показать все заказы конкретного официанта
SELECT *
    FROM ch_orders
    WHERE employee_id=3;
--Показать все заказы конкретного клиента
SELECT *
    FROM ch_orders
    WHERE client_id=4;