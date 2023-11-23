with 

src_orders as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

src_orders_casted as (

    select
        order_id::varchar(50) as order_id,
        (decode(shipping_service,'','---in process---',null,'shipping_service',shipping_service))::varchar(50) as shipping_service,
        shipping_cost::float as shipping_cost_usd,
        address_id::varchar(50) as address_id,
        created_at as full_created_at_utc,
        to_date(created_at) as date_created_at_utc,
        to_time(created_at) as time_created_at_utc,
        decode(promo_id,'','sin_promo',null,'sin_promo',promo_id)::varchar(50) as promo_id,
        estimated_delivery_at as full_estimated_delivery_at,
        to_date(estimated_delivery_at) as date_estimated_delivery_at_utc,
        to_time(estimated_delivery_at) as time_estimated_delivery_at_utc,
        order_cost::float as order_cost_usd,
        user_id::varchar(50) as user_id,
        order_total::float as order_total_usd,
        delivered_at as full_delivered_at,
        to_date(delivered_at) as date_delivered_at,
        to_time(delivered_at) as time_delivered_at,
        cast(decode(tracking_id,'','---in process---',null,'---in_process---',tracking_id) as varchar(50)) as tracking_id,
        status::varchar(50) as status_order,
        _fivetran_deleted::boolean as _fivetran_deleted,
        _fivetran_synced::timestamp_ntz(9) as date_load
    from src_orders
)

select * from src_orders_casted
