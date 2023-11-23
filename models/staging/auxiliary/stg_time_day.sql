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

    year(date_day)*10000+month(date_day)*100+day(date_day) as id_date,
    year(date_day)*100+month(date_day) as id_year_month,
    date_day as _date,
    concat(year(date_day),'-',month(date_day)) as year_month,
    year(date_day) as _year,
    month(date_day) as _month, 
    monthname(date_day) as month_name,
    date_day-1 as previous_day,
    year(date_day)||weekiso(date_day)||dayofweek(date_day) as year_week_day,
    weekiso(date_day) as week

from src_time_day
)

select * from src_time_day_casted

