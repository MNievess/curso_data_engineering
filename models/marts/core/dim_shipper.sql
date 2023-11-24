{{
    config(
        materialized = "table"
    )
}} 

with 

src_shipping as (

    select * from {{ ref('stg_sql_server_dbo_orders') }}

),

src_shipping_casted as (

    select distinct
        shipping_id,
        shipping_service,
        _fivetran_deleted,
        date_load
    from src_shipping
)

select * from src_shipping_casted
