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
                            WHERE order_id=o.id)
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
                            WHERE order_id=o.id)
        WHERE o.id=sid;
END;
--Добавление информации о графике работы в ближайший понедельник
----ближайший понедельник - выходной
INSERT INTO ch_holidays(target_date) VALUES (NEXT_DAY(SYSDATE, 'Понедельник'));
--Добавление информации о новом виде кофе
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('Бутряк','Butriak',2,20.10);
--Изменить расписание работы на ближайший вторник
----сократить рабочий день на 1 час утром и 1 час вечером. 
----указать нерабочее время относительно основного графика
INSERT INTO ch_holidays(target_date,begintime,endtime) VALUES 
    (NEXT_DAY(SYSDATE, 'вторник'),'08:00','09:00');
INSERT INTO ch_holidays(target_date,begintime,endtime) VALUES 
    (NEXT_DAY(SYSDATE, 'вторник'),'18:00','19:00');
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
                        WHERE order_id=o.id)
    WHERE o.id=2;
--Изменить название уже существующего десерта
UPDATE ch_goods
    SET name_ru='Бурдылька Золотая',
        name_en='Golden Burdylka'
    WHERE id=8;
--Удалить конкретный заказ

--Удалить заказы конкретного десерта

--Удалите расписание работы на конкретный день

--Удалите расписание работы на конкретный промежуток между указанными датами

--Показать все заказы конкретного десерта

--Показать расписание работы на конкретный день

--Показать все заказы конкретного официанта

--Показать все заказы конкретного клиента

--Задание 5
--Добавьте к четвертому заданию следующую функциональность:
--Добавление строки;
--Удаление строки;
--Обновление строки