with 

src_orders as (

    select * from {{ ref('base_seed_data__orders') }}

),

src_orders_casted as (

    select
        order_id,
        customer_id,
        store_id,
        staff_id,
        order_date_utf,
        required_date_utf,
        shipped_date_utf,
        order_status
        
    from src_orders

)

select * from src_orders_casted
