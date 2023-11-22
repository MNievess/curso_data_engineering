{{
    config(
        materialized = "table"
    )
}} 

with 

src_shipping as (

    select * from {{ ref('stg_sql_server_dbo_order_items') }}

),

src_shipping_casted as (

    select
        tracking_id,    --poner como pk en el yml de las dim
        shipping_service,
        --status_order,
        _fivetran_deleted,
        date_load
    from src_shipping
)

select * from src_shipping_casted
