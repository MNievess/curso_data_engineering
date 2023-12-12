with 

int_order_items as (
    select * from {{ ref('int__order_items')}}
),

int_full_products as (
    select * from {{ ref('int__full_products')}}
),

int_persons as (
    select * from {{ ref('int__persons')}}
    where customer_id != 'no_customer'
),


fct_sales_customer_casted as (

    select
        d.customer_id,
        d.full_name                         as full_name_customer,
        round(sum(final_price),2)           as total_price_payed_by_customer,
        round(avg(final_price),2)           as average_price_payed_by_customer,
        count(b.product_id)                 as total_products_ordered_by_customer,
        count(distinct model)               as distinct_models_buyed_by_customer,
        count(distinct c.brand_id)          as distinct_brands_buyed_by_customer,
        count(distinct c.category_id)       as distinct_categories_buyed_by_customer,
        count(distinct b.order_id)          as total_orders_ordered_by_customer,
        round(avg(discount_rate),4)         as average_discount_by_customer

    from int_order_items b
    inner join int_full_products c on b.product_id=c.product_id
    inner join int_persons d on b.customer_id=d.customer_id
    group by d.full_name, d.customer_id

)

select * from fct_sales_customer_casted
order by total_price_payed_by_customer desc