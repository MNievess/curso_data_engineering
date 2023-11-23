
with src_dim_time_day as (

    select * from {{ ref('stg_time_day') }}

),

src_dim_time_day_casted as (
select 

    id_date,
    id_year_month,
    _date,
    year_month,
    _year,
    _month, 
    month_name,
    previous_day,
    year_week_day,
    week

from src_dim_time_day
)

select * from src_dim_time_day_casted

