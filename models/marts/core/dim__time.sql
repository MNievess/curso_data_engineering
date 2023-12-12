with

fct_int_time as (
    select * from {{ ref('stg_auxiliary__time_day')}}
),

dim_time_day_casted as (
select 

    date_id,
    month_year_id,
    week_year_id,
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


from fct_int_time
)

select * from dim_time_day_casted