{% set event_types = obtener_tipo_eventos() %}

with src_events as (

    select * from {{ ref('base_events') }}

),

src_events_casted as (

    select
        user_id,
        event_type,
        event_id,
        page_url,
        session_id,
        product_id,
        order_id,
        full_created_at,
        date_created_at,
        time_created_at,
        _fivetran_deleted,
        date_load
    from src_events

)

select * from src_events_casted
