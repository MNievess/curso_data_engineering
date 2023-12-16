with 

src_status_orders as (

    select * from {{ ref('base_seed_data__orders') }}

),

src_status_orders_casted as (

    select distinct
        status_order_id,
        status_order
        
    from src_status_orders

)

select * from src_status_orders_casted