

with src_compras_segun_usuarios1 as (
    select * 
    from {{ ref('stg_sql_server_dbo_orders') }}
    ),


src_compras1 as (
select 
    user_id,
    count(distinct order_id) as compras_por_usuario
 
from src_compras_segun_usuarios1
group by 1
),


src_compras2 as (
select
    case 
        when compras_por_usuario >=3 then '3 o más compras'
        else cast(compras_por_usuario as varchar)
        end as compras_usuario,
    count(user_id) as num_users
from src_compras1
group by 1
)

select * from src_compras2
