{{ 
    config(
        materialized='table', 
        sort='date_day',
        dist='date_day',
        pre_hook="alter session set timezone = 'Europe/Madrid'; alter session set week_start = 7;" 
        ) 
}}

with src_time_day as (

    {{ dbt_date.get_date_dimension('2018-01-01', '2025-12-31') }}

),

src_time_day_casted as (
select 

    {{dbt_utils.generate_surrogate_key(['date_day'])}}::varchar(50) as date_id,
    date_day as full_date,
    date_day-1 as previous_day,
    date_day+1 as next_day,
    concat(month(date_day),'-',year(date_day)) as month_year,
    year(date_day) as _year,
    concat(weekiso(date_day),'-',_year) as week_year

from src_time_day
)

select * from src_time_day_casted

