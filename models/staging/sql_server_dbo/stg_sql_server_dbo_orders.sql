with 

src_orders as (

    select * from {{ ref('base_orders') }}

),

src_orders_casted as (

    select
        order_id,
        {{dbt_utils.generate_surrogate_key(['shipping_service'])}} as shipping_id,
        shipping_service,
        shipping_cost_usd,
        address_id,
        full_created_at_utc,
        date_created_at_utc,
        time_created_at_utc,
        promo_id,
        full_estimated_delivery_at,
        date_estimated_delivery_at_utc,
        time_estimated_delivery_at_utc,
        order_cost_usd,
        user_id,
        order_total_usd,
        full_delivered_at,
        date_delivered_at,
        time_delivered_at,
        tracking_id,
        status_order,
        _fivetran_deleted,
        date_load
    from src_orders
)

select * from src_orders_casted
