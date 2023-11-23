{% set event_types = obtener_tipo_eventos() %}

with src_events as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

src_events_casted as (

    select
        user_id::varchar(50) as user_id,
        event_type::varchar(50) as event_type,
        event_id::varchar(50) as event_id,
        page_url::varchar(250) as page_url,
        session_id::varchar(50) as session_id,
        decode(product_id,'','no_product',null,'no_product',product_id)::varchar(50) as product_id,
        decode(order_id,'','no_order',null,'no_order',order_id)::varchar(50) as order_id,
        created_at::timestamp_tz as full_created_at,
        to_date(created_at) as date_created_at,
        to_time(created_at) as time_created_at,
        _fivetran_deleted,
        _fivetran_synced as date_load
    from src_events

)

select * from src_events_casted

