with 

src_fct_orders as (
    select * from {{ ref('stg_sql_server_dbo_orders') }}
),

src_fct_order_items as (
    select * from {{ ref('stg_sql_server_dbo_order_items') }}
),

src_fct_products as (
    select * from {{ ref('stg_sql_server_dbo_products') }}
),

src_fct_orders_casted as (

    select
        a.order_id,
        date_created_at_utc,
        time_created_at_utc,
        user_id,
        b.product_id,
        c.price_usd as unit_price,
        promo_id,
        quantity_items,
        price_usd*quantity_items as total_price_product
        
    from src_fct_orders a
    inner join src_fct_order_items b on a.order_id=b.order_id
    inner join src_fct_products c on b.product_id=c.product_id
    order by date_created_at_utc asc
)

select * from src_fct_orders_casted

