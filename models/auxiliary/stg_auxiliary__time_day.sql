{{ 
    config(
        materialized='table', 
        sort='date_day',
        dist='date_day',
        pre_hook="alter session set timezone = 'Europe/Madrid'; alter session set week_start = 7;" 
        ) 
}}

with 

src_time_day as (
    {{ dbt_date.get_date_dimension('2018-01-01', '2025-12-31') }}
),


src_time_day_casted as (
    
    select 

        date_day,
        year(date_day)*100+month(date_day) as year_month_id,
        date_day as full_date,
        date_day-1 as previous_day,
        date_day+1 as next_day,
        year(date_day) as _year,
        concat(quarter(date_day),'-',_year) as quarter_year,
        concat(month(date_day),'-',year(date_day)) as month_year,
        concat(weekiso(date_day),'-',_year) as week_year,
        to_date(GETDATE()) as now
        

    from src_time_day 

),

src_time_day_postcasted as (

    select

        {{dbt_utils.generate_surrogate_key(['date_day'])}}::varchar(50) as date_id,
        {{dbt_utils.generate_surrogate_key(['month_year'])}}::varchar(50) as month_year_id,
        {{dbt_utils.generate_surrogate_key(['week_year'])}}::varchar(50) as week_year_id,
        date_day,
        year_month_id,
        full_date,
        previous_day,
        next_day,
        month_year,
        _year,
        quarter_year,
        week_year,
        now

    from src_time_day_casted

)

select * from src_time_day_postcasted

