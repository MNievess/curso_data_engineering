with src_order_items as (

    select * 
        from {{ source('sql_server_dbo', 'order_items') }}
),

src_order_items_casted as (
    select
        order_id::varchar(50) as order_id,
        product_id::varchar(50) as product_id,
        quantity::number(38,0) as quantity_items,
        _fivetran_deleted::boolean as _fivetran_deleted,
        _fivetran_synced::timestamp_ntz as date_load
    from src_order_items
)

select * from src_order_items_casted
