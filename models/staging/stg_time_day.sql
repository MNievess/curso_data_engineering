{{
    config(
        materialized = "view"
    )
}} 

with src_time_day as (

    {{ dbt_date.get_date_dimension('2018-01-01', '2022-12-31') }}

),

src_time_day_casted as (
select *
    --date_day, 
    --month_start_date, 
    --month_name
from src_time_day
)

select top 100 * from src_time_day_casted

