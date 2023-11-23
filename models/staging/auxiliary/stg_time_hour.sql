
with src_time_hour as (

    {{ dbt_date.get_base_dates(n_dateparts=24*28, datepart="hour") }}

),

src_time_hour_casted as (
select *

from src_time_hour
)

select * from src_time_hour_casted


