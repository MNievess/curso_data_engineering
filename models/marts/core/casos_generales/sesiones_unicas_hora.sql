with src_sesiones_unicas_hora as (

    select * from {{ ref('stg_sql_server_dbo_events') }}

),

src_sesiones_unicas_hora_casted as (
select distinct
    session_id,
    DATE_TRUNC ('hour', full_created_at) as horas

from src_sesiones_unicas_hora
--group by 2

)

select * from src_sesiones_unicas_hora_casted