--Изменить цену на определенный вид кофе
UPDATE ch_goods 
    SET price=10.50
    WHERE id=1;
--Изменить контактный, почтовый адрес кондитеру
UPDATE ch_employees
    SET email='popr1@ch.ua'
    WHERE id=6;
--Изменить контактный телефон бариста
SELECT phone1, phone2
    FROM ch_employees
    WHERE position_id=1;
--Изменить процент скидки конкретного клиента
UPDATE ch_clients
    SET discount=1
    WHERE id=4;
--Удалить информацию о конкретном десерте
UPDATE ch_goods
    SET deleted='Y'
    WHERE id=7;
--Удалите информацию об определенном официанте
UPDATE ch_employees
    SET deleted='Y'
    WHERE id=3;
--Удалите информацию об определенном бариста
UPDATE ch_employees
    SET deleted='Y'
    WHERE id=2;
--Удалите информацию о конкретном клиенте
UPDATE ch_clients
    SET deleted='Y'
    WHERE id=4;
--Покажите все напитки
SELECT *
    FROM ch_goods
    WHERE category_id=2;
--Покажите все десерты
SELECT *
    FROM ch_goods
    WHERE category_id=1;
--Покажите информацию обо всех бариста
SELECT *
    FROM ch_employees
    WHERE position_id=1;
--Покажите информацию обо всех официантах
SELECT *
    FROM ch_employees
    WHERE position_id=2;