with 

int_order_items as (
    select * from {{ ref('int__order_items')}}
),

int_full_products as (
    select * from {{ ref('int__full_products')}}
),


fct_sales_brand_casted as (

    select
        d.brand_id,
        d.brand,
        count(distinct b.customer_id)       as total_customer_buyers_by_brand,
        count(distinct b.order_id)          as total_orders_by_brand,
        round(sum(final_price),2)           as total_price_earned_by_brand,
        count(b.product_id)                 as total_ordered_products_by_brand,
        count(distinct model)               as distinct_models_sold_by_brand,
        round(avg(d.list_price_usd),2)      as average_price_by_brand
        
    from int_order_items b
    inner join int_full_products d on b.product_id=d.product_id
    group by d.brand, d.brand_id

)

select * from fct_sales_brand_casted
order by total_price_earned_by_brand desc