with 

fct_orders as (
    select * from {{ ref('stg_seed_data__orders') }}
),

fct_order_items as (
    select * from {{ ref('int__order_items')}}
),

fct_status_orders as (
    select * from {{ ref('stg_auxiliary__status_orders')}}
),

fct_discount_orders as (
    select * from {{ ref('stg_auxiliary__discount_orders')}}
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
        b.unity_price_list as unity_price_list,
        d.discount_rate,
        b.unity_product_price,
        b.final_price,
        c.status_order_id
        
    from fct_orders a
    inner join fct_order_items b on a.order_id=b.order_id
    inner join fct_status_orders c on b.status_order_id=c.status_order_id
    inner join fct_discount_orders d on b.discount_id=d.discount_id

)

select * from fct_orders_casted