
with src_tiempo_entrega_pedido as (

    select * from {{ ref('stg_sql_server_dbo_orders') }}

),


src_tiempo_entrega_pedido_casted as (
select 

    --DATEDIFF (hour, full_created_at_utc, full_delivered_at ) as diferencia_horas,
    --DATEDIFF (day, full_created_at_utc, full_delivered_at ) as diferencia_dias, 
    truncate(avg(DATEDIFF (day, full_created_at_utc, full_delivered_at )),2) as media_dias,
    truncate(avg(DATEDIFF (hour, full_created_at_utc, full_delivered_at )),2) as media_horas

from src_tiempo_entrega_pedido

)

select * from src_tiempo_entrega_pedido_casted