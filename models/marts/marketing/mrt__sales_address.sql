with 

fct_orders as (
    select * from {{ ref('stg_seed_data__orders')}}
),

fct_order_items as (
    select * from {{ ref('stg_seed_data__order_items')}}
),

int_full_products as (
    select * from {{ ref('int__full_products')}}
),

src_customer as (
    select * from {{ ref('stg_seed_data__customer')}}
),


fct_sales_address_casted as (

    select
        distinct(concat(d.city, ' - ' ,d.state)) as address,
        round(sum(final_price),2) as total_price_payed_by_address,
        round(avg(final_price),2) as average_price_payed_by_address,
        count(b.product_id) as total_products_ordered_by_address,
        count(distinct model) as distinct_models_buyed_by_address,
        --count(distinct c.brand_id) as distinct_brands_buyed_by_address,
        count(distinct c.category_id) as distinct_categories_buyed_by_address,
        count(distinct b.order_id) as total_orders_ordered_by_address,
        count(distinct a.customer_id) as total_customer_by_address
        
    from fct_orders a
    inner join fct_order_items b on a.order_id=b.order_id
    inner join int_full_products c on b.product_id=c.product_id
    inner join src_customer d on a.customer_id=d.customer_id
    group by concat(d.city, ' - ' ,d.state)

)

select * from fct_sales_address_casted
order by total_price_payed_by_address desc