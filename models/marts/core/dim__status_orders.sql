with 

src_status_orders as (

    select * from {{ ref('stg_status_orders') }}

),

src_status_orders_casted as (

    select distinct
        status_order_id,
        order_status
        
    from src_status_orders

)

select * from src_status_orders_casted