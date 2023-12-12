with 

int_order_items as (
    select * from {{ ref('int__order_items')}}
),

int_full_products as (
    select * from {{ ref('int__full_products')}}
),


fct_sales_category_casted as (

    select
        d.category_id,
        d.category,
        count(distinct b.customer_id)       as total_customer_attended_by_category,
        count(d.product_id)                 as total_products_sold_by_category,
        round(sum(final_price),2)           as total_price_earned_by_category,
        count(b.product_id)                 as total_ordered_products_by_category,
        count(distinct model)               as distinct_models_sold_by_category,
        round(avg(d.list_price_usd),2)      as average_price_by_category
        
    from int_order_items b
    inner join int_full_products d on b.product_id=d.product_id
    group by d.category, d.category_id

)

select * from fct_sales_category_casted
order by total_price_earned_by_category desc