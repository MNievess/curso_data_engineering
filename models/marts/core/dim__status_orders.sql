with 

src_status_orders as (

    select * from {{ ref('stg_auxiliary__status_orders') }}

),

src_status_orders_casted as (

    select distinct
        status_order_id,
        status_order
        
    from src_status_orders

)

select * from src_status_orders_casted