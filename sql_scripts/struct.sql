/*
    This script works well with BigQuery's SQL. 
    It's a neat trick to create tables via CTEs without using temporary tables in a script.
*/

with countries as (
    select
    [
        STRUCT("Sint Maarten" as name, "SX" as alpha2, "SXM" as alpha3),
        STRUCT("Cape Verde" as name, "CV" as alpha2, "CPV" as alpha3),
        STRUCT("Curacao" as name, "CW" as alpha2, "CUW" as alpha3),
        STRUCT("British Virgin Islands" as name, "VG" as alpha2, "VGB" as alpha3),
        STRUCT("The Bahamas" as name, "BS" as alpha2, "BHS" as alpha3),
        STRUCT("Brunei" as name, "BN" as alpha2, "BRN" as alpha3),
        STRUCT("Cote d'Ivoire" as name, "CI" as alpha2, "CIV" as alpha3),
        STRUCT("Czechia" as name, "CZ" as alpha2, "CZE" as alpha3),
        STRUCT("Democratic Republic of the Congo" as name, "CD" as alpha2, "COD" as alpha3),
        STRUCT("Federated States of Micronesia" as name, "FM" as alpha2, "FSM" as alpha3),
        STRUCT("Kosovo" as name, "XK" as alpha2, "UNK" as alpha3),
        STRUCT("Laos" as name, "LA" as alpha2, "LAO" as alpha3),
        STRUCT("Myanmar (Burma)" as name, "MM" as alpha2, "MMR" as alpha3),
        STRUCT("Republic of the Congo" as name, "CG" as alpha2, "COG" as alpha3),
        STRUCT("Reunion" as name, "RE" as alpha2, "REU" as alpha3),
        STRUCT("Russia" as name, "RU" as alpha2, "RUS" as alpha3),
        STRUCT("The Gambia" as name, "GM" as alpha2, "GMB" as alpha3),
        STRUCT("U.S. Virgin Islands" as name, "VI" as alpha2, "VIR" as alpha3),
        STRUCT("United States of America" as name, "US" as alpha2, "USA" as alpha3)
    ] as cnames
), 

extra_countries as (
    select 
        ec.name, 
        ec.alpha2, 
        ec.alpha3 
    from countries
    cross join UNNEST(countries.cnames) as ec
) 

select * 
from extra_countries
