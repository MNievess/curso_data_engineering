with 

src_orders as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

src_orders_casted as (

    select
        order_id::varchar(50) as order_id,
        shipping_service::varchar() as shipping_service,
        shipping_cost::float as shipping_cost,
        address_id::varchar(50) as address_id,
        created_at::timestamp_tz as created_at,
        promo_id::varchar(50) as promo_id,
        estimated_delivery_at::timestamp_tz as estimated_delivery_at,
        order_cost::float as order_cost,
        user_id::varchar(50) as user_id,
        order_total::float as order_total,
        delivered_at::timestamp_tz as delivered_at,
        tracking_id::varchar(50) as tracking_id,
        status::varchar(50) as status,
        _fivetran_deleted::boolean as _fivetran_deleted,
        _fivetran_synced::timestamp_ntz(9) as date_load

    from src_orders

)

select * from src_orders_casted
