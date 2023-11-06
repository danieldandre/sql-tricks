--Creating "numbers_array" utility
create temporary table if not exists num_array
(
    numbers int32
)

insert into num_array (numbers) values (1)
insert into num_array (numbers) values (2)
insert into num_array (numbers) values (3)
insert into num_array (numbers) values (4)
insert into num_array (numbers) values (5)

--Creating "dummy" table with nested arrays
drop table dummy;
create temporary table if not exists dummy
(
    id bigint,
    activity_date date,
    nested_array varchar(5000)
)

insert into dummy (id, activity_date, nested_array) values (1, '2023-01-01', '[{"product_family":"currency","amount":60,"product_id":"coin"},{"product_family":"player","amount":9,"product_id":"Character11"},{"product_family":"player","amount":2,"product_id":"Character41"},{"product_family":"player","amount":1,"product_id":"Character54"}]');
insert into dummy (id, activity_date, nested_array) values (2, '2023-01-01', '[{"product_family":"currency","amount":32,"product_id":"coin"},{"product_family":"player","amount":3,"product_id":"Character14"},{"product_family":"player","amount":2,"product_id":"Character3"}]');
insert into dummy (id, activity_date, nested_array) values (3, '2023-01-01', '[{"product_family":"gear","amount":1,"product_id":"ClothSocksCuscos"}]');
insert into dummy (id, activity_date, nested_array) values (4, '2023-01-01', '[{"product_family":"currency","amount":33,"product_id":"coin"},{"product_family":"player","amount":4,"product_id":"Character20"},{"product_family":"gear","amount":1,"product_id":"ClothShortDenmark"}]');
insert into dummy (id, activity_date, nested_array) values (5, '2023-01-01', '[{"product_family":"currency","amount":56,"product_id":"coin"},{"product_family":"player","amount":1,"product_id":"Character158"},{"product_family":"player","amount":11,"product_id":"Character25"},{"product_family":"gear","amount":1,"product_id":"ClothBallWorldcup"}]');
insert into dummy (id, activity_date, nested_array) values (6, '2023-01-01', '[{"product_family":"currency","amount":166,"product_id":"coin"},{"product_family":"player","amount":2,"product_id":"Character46"},{"product_family":"player","amount":10,"product_id":"Character4"},{"product_family":"player","amount":4,"product_id":"Character56"},{"product_family":"gear","amount":1,"product_id":"ClothShortWarriors"}]');
insert into dummy (id, activity_date, nested_array) values (7, '2023-01-01', '[{"product_family":"currency","amount":131,"product_id":"coin"},{"product_family":"player","amount":2,"product_id":"Character1"},{"product_family":"player","amount":2,"product_id":"Character8"},{"product_family":"gear","amount":1,"product_id":"ClothLogoPolice"},{"product_family":"gear","amount":1,"product_id":"ClothLogoBandits"}]');
insert into dummy (id, activity_date, nested_array) values (8, '2023-01-01', '[{"product_family":"currency","amount":493,"product_id":"coin"},{"product_family":"currency","amount":2,"product_id":"gem"},{"product_family":"player","amount":7,"product_id":"Character12"},{"product_family":"player","amount":17,"product_id":"Character23"},{"product_family":"player","amount":4,"product_id":"Character61"},{"product_family":"player","amount":3,"product_id":"Character64"},{"product_family":"player","amount":11,"product_id":"Character15"}]');
insert into dummy (id, activity_date, nested_array) values (9, '2023-01-01', '[{"product_family":"currency","amount":578,"product_id":"coin"},{"product_family":"currency","amount":3,"product_id":"gem"},{"product_family":"player","amount":8,"product_id":"Character19"},{"product_family":"player","amount":12,"product_id":"Character26"},{"product_family":"player","amount":12,"product_id":"Character3"},{"product_family":"player","amount":4,"product_id":"Character58"},{"product_family":"player","amount":4,"product_id":"Character47"},{"product_family":"gear","amount":1,"product_id":"ClothShoesHarpy"}]');
