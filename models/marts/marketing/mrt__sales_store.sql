with 

int_order_items_s as (
    select * from {{ ref('int__order_items')}}
),

int_full_products as (
    select * from {{ ref('int__full_products')}}
),

stg_store as (
    select * from {{ ref('stg_seed_data__stores')}}
),


fct_sales_store_s_casted as (

    select
        b.store_id,
        a.store_name,
        count(b.customer_id)                as total_customer_attended_by_store,
        round(sum(final_price),2)           as total_price_earned_by_store,
        count(b.product_id)                 as total_ordered_products_by_store,
        count(distinct model)               as distinct_models_sold_by_store,
        count(distinct d.brand_id)          as distinct_brands_sold_by_store,
        count(distinct b.order_id)          as total_orders_ordered_by_store,
        round(avg(discount_rate),4)         as average_discount_by_store,
        round(avg(final_price),2)           as average_ticket_by_store
        
    from int_order_items_s b
    inner join int_full_products d on b.product_id=d.product_id
    inner join stg_store a on b.store_id=a.store_id
    group by a.store_name, b.store_id

)

select * from fct_sales_store_s_casted
order by total_price_earned_by_store desc