
with src_numero_usuarios as (

    select * from {{ ref('stg_sql_server_dbo_users') }}

),

src_numero_usuarios_casted as (
select 
    count(user_id) as numero_usuarios

from src_numero_usuarios
)

select * from src_numero_usuarios_casted
