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


fct_sales_customer_casted as (

    select
        a.customer_id,
        round(sum(final_price),2) as total_price_payed_by_customer,
        round(avg(final_price),2) as average_price_payed_by_customer,
        count(b.product_id) as total_products_ordered_by_customer,
        count(distinct model) as distinct_models_buyed_by_customer,
        count(distinct c.brand_id) as distinct_brands_buyed_by_customer,
        count(distinct c.category_id) as distinct_categories_buyed_by_customer,
        count(distinct b.order_id) as total_orders_ordered_by_customer,
        round(avg(discount_rate),4) as average_discount_by_customer

        
    from fct_orders a
    inner join fct_order_items b on a.order_id=b.order_id
    inner join int_full_products c on b.product_id=c.product_id
    group by a.customer_id

)

select * from fct_sales_customer_casted
order by total_price_payed_by_customer desc