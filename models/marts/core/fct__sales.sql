with 

fct_orders as (
    select * from {{ ref('stg_seed_data__orders') }}
),

fct_order_items as (
    select * from {{ ref('stg_seed_data__order_items')}}
),

int_orders as (
    select * from {{ ref('int__orders')}}
),



fct_orders_casted as (

    select
        a.order_id,
        a.customer_id,
        a.store_id,
        a.staff_id,
        order_date_utf,
        required_date_utf,
        shipped_date_utf,
        b.product_id,
        b.item_id,
        b.order_item_quantity,
        b.list_price_$ as unity_price_list,
        b.order_item_discount_rate as unity_discount,
        b.unity_product_price,
        b.final_price,
        a.order_status
        
    from fct_orders a
    inner join fct_order_items b on a.order_id=b.order_id

)

select * from fct_orders_casted