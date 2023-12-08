with 

src_status_orders as (

    select * from {{ ref('base_seed_data__orders') }}

),

src_status_orders_casted as (

    select distinct
        {{dbt_utils.generate_surrogate_key(['order_status'])}}::varchar(50) as status_order_id,
        order_status
        
    from src_status_orders

)

select * from src_status_orders_casted