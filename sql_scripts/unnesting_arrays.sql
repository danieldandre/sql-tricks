--Creating "numbers_array" utility
drop table num_array;
create temporary table if not exists num_array
(
    numbers int2
)

insert into num_array (numbers) values (0);
insert into num_array (numbers) values (1);
insert into num_array (numbers) values (2);
insert into num_array (numbers) values (3);
insert into num_array (numbers) values (4);
insert into num_array (numbers) values (5);
insert into num_array (numbers) values (6);
insert into num_array (numbers) values (7);

--Creating "dummy" table with nested arrays
drop table dummy;
create temporary table if not exists dummy
(
    id int8,
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

--Logic to unnest arrays
with dummy as (--Dummy data
    select * from dummy
    limit 400
),

num_util as (--Utilities
    select * from num_array
),

extracted as (--Array length
    select
        id,
        activity_date,
        nested_array,
        JSON_ARRAY_LENGTH(nested_array) as nested_array_length
    from dummy
),

unnested_rows as ( --Cartesian join of prior select statements with utility table with numbers
    select
        id,
        activity_date,
        nested_array,
        nested_array_length,
        num_util.numbers,
        case
            when nested_array_length >= 1
                then JSON_EXTRACT_ARRAY_ELEMENT_TEXT(nested_array, cast(num_util.numbers as int2))
            else nested_array
        end as nested_array_extraction
    from extracted, num_util
    where num_util.numbers < extracted.nested_array_length --Will create a zero-indexed column with one row per array size per id/ref_id
),

arrays_to_columns as (
    select
        id,
        activity_date,
        nested_array_extraction,
        json_extract_path_text(nested_array_extraction, 'product_family') as product_family,
        json_extract_path_text(nested_array_extraction, 'amount') as amount,
        json_extract_path_text(nested_array_extraction, 'product_id') as product_id
    from unnested_rows
)

select * from arrays_to_columns

/*
Notes:
- int8 is the same as bigint
- JSON_EXTRACT_ARRAY_ELEMENT_TEXT is zero-indexed
*/