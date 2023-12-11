with 

fct_orders as (
    select * from {{ ref('stg_seed_data__orders') }}
),

fct_order_items as (
    select * from {{ ref('stg_seed_data__order_items')}}
),

fct_discount_orders as (
    select * from {{ ref('stg_auxiliary__discount_orders')}}
),

fct_order_status as (
    select * from {{ ref('stg_auxiliary__status_orders')}}
),


fct_orders_casted as (

    select
        a.order_id,
        a.customer_id,
        a.store_id,
        a.staff_id,
        d.status_order_id,
        d.status_order,
        a.order_date_utf,
        a.required_date_utf,
        a.shipped_date_utf,
        b.product_id,
        b.item_id,
        b.order_item_quantity,
        b.list_price_usd as unity_price_list,
        c.discount_id,
        c.discount_rate,
        b.list_price_usd-(b.list_price_usd*c.discount_rate) as unity_product_price,
        (b.list_price_usd-(b.list_price_usd*c.discount_rate))*b.order_item_quantity as final_price
        
        
    from fct_orders a
    inner join fct_order_items b on a.order_id=b.order_id
    inner join fct_discount_orders c on b.discount_id=c.discount_id
    inner join fct_order_status d on a.status_order_id=d.status_order_id

)

select * from fct_orders_casted