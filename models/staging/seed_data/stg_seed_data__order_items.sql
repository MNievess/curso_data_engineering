with 

src_order_items as (

    select * from {{ source('seed_data', 'order_items') }}

),

src_order_items_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['order_id'])}}::varchar(50) as order_id,
        item_id::number(38,0) as item_id,
        {{dbt_utils.generate_surrogate_key(['product_id'])}}::varchar(50) as product_id,
        quantity::number(38,0) as order_item_quantity,
        list_price::number (38,0) as list_price_usd,
        round(list_price-(list_price*discount),2)::number(38,2) as unity_product_price,
        round((list_price-(list_price*discount))*order_item_quantity,2)::number(38,2) as final_price,
        {{dbt_utils.generate_surrogate_key(['discount'])}}::varchar(50) as discount_id,
        discount::number(38,2) as discount_rate
        

    from src_order_items

)

select * from src_order_items_casted
