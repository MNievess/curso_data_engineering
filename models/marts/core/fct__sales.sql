with 


fct_order_items as (
    select * from {{ ref('int__order_items')}}
),

fct_time as (
    select * from {{ ref('stg_auxiliary__time_day')}}
),



fct_sales_casted as (

    select
        order_id,
        customer_id,
        store_id,
        staff_id,
        order_date_utf,
        required_date_utf,
        shipped_date_utf,
        product_id,
        item_id,
        order_item_quantity,
        unity_price_list,
        discount_rate,
        unity_product_price,
        final_price,
        status_order_id
        
    from fct_order_items

)

select * from fct_sales_casted