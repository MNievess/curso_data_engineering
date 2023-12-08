with 

fct_orders as (

    select * from {{ ref('stg_seed_data__orders') }}

),

fct_order_items as (
    select * from {{ ref('stg_seed_data__order_items')}}
),

fct_orders_casted as (

    select
        a.order_id,
        a.customer_id,
        b.product_id,
        b.item_id,
        b.order_item_quantity,
        b.list_price_$ as unity_price_list,
        b.order_item_discount_rate as unity_discount,
        b.list_price_$-(b.list_price_$*b.order_item_discount_rate) as unity_product_price,
        (b.list_price_$-(b.list_price_$*b.order_item_discount_rate))*b.order_item_quantity as final_price
        
    from fct_orders a
    inner join fct_order_items b on a.order_id=b.order_id

)

select * from fct_orders_casted