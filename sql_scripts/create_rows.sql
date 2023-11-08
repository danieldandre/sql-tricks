/*
    A very obvious trick for creating a sequence of numbers or data in a single column.
    Logic works both as a CTE or as a temporary table. 
*/

create temporary table seq as (
    select 0 as i union all
    select 1 union all
    select 2 union all
    select 3 union all
    select 4 union all
    select 5
);

select * from seq