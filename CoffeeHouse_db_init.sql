ALTER SESSION SET
    NLS_DATE_LANGUAGE = RUSSIAN
    NLS_DATE_FORMAT = 'DD.MM.YYYY'
    NLS_TIME_FORMAT = 'HH24:MI:SS'
    NLS_TIMESTAMP_FORMAT = 'DD.MM.YYYY HH24:MI:SS';
----
CREATE TABLE ch_categories(
    id INT GENERATED AS IDENTITY PRIMARY KEY
    ,name_ru NVARCHAR2(30)NOT NULL
    ,name_en VARCHAR(30)NOT NULL
    ,deleted CHAR(1) DEFAULT('N') CHECK(deleted IN ('N','Y'))
);
CREATE TABLE ch_goods(
    id INT GENERATED AS IDENTITY PRIMARY KEY
    ,name_ru NVARCHAR2(100)NOT NULL
    ,name_en VARCHAR(100)NOT NULL
    ,category_id INT NOT NULL
        CONSTRAINT fk_goods_category_id REFERENCES ch_categories(id)
    ,price NUMBER(17,2) DEFAULT(0)
    ,deleted CHAR(1) DEFAULT('N') CHECK(deleted IN ('N','Y'))
);
CREATE TABLE ch_positions(
    id INT GENERATED AS IDENTITY PRIMARY KEY
    ,name NVARCHAR2(30)NOT NULL
    ,deleted CHAR(1) DEFAULT('N') CHECK(deleted IN ('N','Y'))
);
CREATE TABLE ch_employees(
    id INT GENERATED AS IDENTITY PRIMARY KEY
    ,full_name NVARCHAR2(50) NOT NULL
    ,phone1 VARCHAR(13) NOT NULL
    ,phone2 VARCHAR(13) NULL
    ,email VARCHAR(250) NULL
    ,position_id INT
        CONSTRAINT fk_employees_position_id REFERENCES ch_positions(id)
    ,deleted CHAR(1) DEFAULT('N') CHECK(deleted IN ('N','Y'))
);
CREATE TABLE ch_clients(
    id INT GENERATED AS IDENTITY PRIMARY KEY
    ,full_name NVARCHAR2(50) NOT NULL
    ,birthday DATE NULL
    ,phone VARCHAR(13) NOT NULL
    ,address NVARCHAR2(250) NULL
    ,discount SMALLINT DEFAULT(0) CHECK(discount < 50)
    ,deleted CHAR(1) DEFAULT('N') CHECK(deleted IN ('N','Y'))
);
CREATE TABLE ch_shedules_static(
    weekday NVARCHAR2(13) PRIMARY KEY
    ,begintime CHAR(5) NOT NULL
    ,endtime CHAR(5) NOT NULL
);
CREATE TABLE ch_holidays(
    --identifier is useless
    target_date_begin DATE NOT NULL
    ,target_date_end DATE NOT NULL
    ,begintime CHAR(5) NULL
    ,endtime CHAR(5) NULL
);
CREATE TABLE ch_orders(
    --автоинкремент работает через последовательность
    id INT PRIMARY KEY--GENERATED AS IDENTITY PRIMARY KEY
    ,created_on TIMESTAMP NOT NULL
    ,closed_on TIMESTAMP NULL
    ,employee_id INT NOT NULL
        CONSTRAINT fk_orders_employee_id REFERENCES ch_employees(id)
    ,client_id INT NOT NULL
        CONSTRAINT fk_orders_client_id REFERENCES ch_clients(id)
    ,discount INT DEFAULT(0) CHECK(discount < 100)
    ,total_sum NUMBER(17,2) DEFAULT(0)
    ,deleted CHAR(1) DEFAULT('N') CHECK(deleted IN ('N','Y'))
);
CREATE TABLE ch_order_details(
    id INT GENERATED AS IDENTITY PRIMARY KEY
    ,order_id INT NOT NULL
        CONSTRAINT fk_order_details_order_id REFERENCES ch_orders(id)
    ,product_id INT NOT NULL
        CONSTRAINT fk_order_details_product_id REFERENCES ch_goods(id)
    ,price NUMBER(17,2) NOT NULL
    ,quantity NUMBER(6,3) NOT NULL
    ,deleted CHAR(1) DEFAULT('N') CHECK(deleted IN ('N','Y'))
);
----
--DROP TABLE ch_order_details;
--DROP TABLE ch_orders;
--DROP TABLE ch_holidays;
--DROP TABLE ch_shedules_static;
--DROP TABLE ch_clients;
--DROP TABLE ch_employees;
--DROP TABLE ch_positions;
--DROP TABLE ch_goods;
--DROP TABLE ch_categories;
----
INSERT INTO ch_categories(name_ru,name_en) VALUES ('Десерт','Dessert');--1
INSERT INTO ch_categories(name_ru,name_en) VALUES ('Напиток','Drink');--2
--
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('Шмурдик','Shmurdik',2,7.50);--1
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('Грымзик','Grymsik',2,17.00);--2
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('Дубаратор','Dubarator',2,10.35);--3
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('Бздыш','Bzdysh',2,8.99);--4
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('Запырка','Zapyrka',1,37.00);--5
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('Охлотушка','Ohlotushka',1,48.00);--6
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('Тумельница','Turmelnitsa',1,35.00);--7
INSERT INTO ch_goods(name_ru,name_en,category_id,price) VALUES 
    ('Бурдылька','Burdylka',1,60.00);--8
--
INSERT INTO ch_positions(name) VALUES ('Бариста');--1
INSERT INTO ch_positions(name) VALUES ('Официант');--2
INSERT INTO ch_positions(name) VALUES ('Кондитер');--3
--
INSERT INTO ch_employees(full_name,phone1,phone2,email,position_id) VALUES 
    ('Кофеман Обжаренов','+380675552299',NULL,'koob@ch.ua',1);--1
INSERT INTO ch_employees(full_name,phone1,phone2,email,position_id) VALUES 
    ('Капучин Карамелькин','+380675552201','+380505552201','kaka@ch.ua',1);--2
INSERT INTO ch_employees(full_name,phone1,phone2,email,position_id) VALUES 
    ('Поднос Круглов','+380673331100','+380504446677','pokr@ch.ua',2);--3
INSERT INTO ch_employees(full_name,phone1,phone2,email,position_id) VALUES 
    ('Чайник Свистунов','+380673331101','+380504446678','chasv@ch.ua',2);--4
INSERT INTO ch_employees(full_name,phone1,phone2,email,position_id) VALUES 
    ('Патока Тортова','+380679998800',NULL,'pato@ch.ua',3);--5
INSERT INTO ch_employees(full_name,phone1,phone2,email,position_id) VALUES 
    ('Пончик Припудренков','+380679598830',NULL,'popr@ch.ua',3);--6
--
INSERT INTO ch_clients(full_name,birthday,phone,address,discount) VALUES 
    ('Васька Крутой','01.01.2000','+380670077700','пл. Центральная 5/7',15);--1
INSERT INTO ch_clients(full_name,birthday,phone,address,discount) VALUES 
    ('Пуська Рыжая','07.07.1998','+380670101010','ул. Окружная 1-б',10);--2
INSERT INTO ch_clients(full_name,birthday,phone,address,discount) VALUES 
    ('Бабка Дикая','05.04.1945','+380671234567',NULL,5);--3
INSERT INTO ch_clients(full_name,birthday,phone) VALUES 
    ('Дед Рыхлый','12.12.1912','+380677654321');--4
--
INSERT INTO ch_shedules_static(weekday,begintime,endtime) VALUES 
    ('Понедельник','08:00','19:00');--1
INSERT INTO ch_shedules_static(weekday,begintime,endtime) VALUES 
    ('Вторник','08:00','19:00');--2
INSERT INTO ch_shedules_static(weekday,begintime,endtime) VALUES 
    ('Среда','08:00','19:00');--3
INSERT INTO ch_shedules_static(weekday,begintime,endtime) VALUES 
    ('Четверг','08:00','19:00');--4
INSERT INTO ch_shedules_static(weekday,begintime,endtime) VALUES 
    ('Пятница','08:00','19:00');--5
INSERT INTO ch_shedules_static(weekday,begintime,endtime) VALUES 
    ('Суббота','09:00','18:00');--6
INSERT INTO ch_shedules_static(weekday,begintime,endtime) VALUES 
    ('Воскресенье','10:00','17:00');--7
------