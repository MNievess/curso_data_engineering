with 

fct_orders_s as (
    select * from {{ ref('stg_seed_data__orders')}}
),

fct_order_items_s as (
    select * from {{ ref('stg_seed_data__order_items')}}
),

int_full_products as (
    select * from {{ ref('int__full_products')}}
),


fct_sales_store_s_casted as (

    select
        a.store_id,
        round(sum(final_price),2) as total_price_earned_by_store,
        count(b.product_id) as total_ordered_products_by_store,
        count(distinct model) as distinct_models_sold_by_store,
        count(distinct d.brand_id) as distinct_brands_sold_by_store,
        count(distinct b.order_id) as total_orders_ordered_by_store,
        count(distinct a.customer_id) as total_customer_attended_by_store,
        round(avg(discount_rate),4) as average_discount_by_store,
        round(avg(final_price),2) as average_ticket_by_store
        
    from fct_orders_s a
    full join fct_order_items_s b on a.order_id=b.order_id
    inner join int_full_products d on b.product_id=d.product_id
    group by a.store_id

)

select * from fct_sales_store_s_casted
order by total_price_earned_by_store desc