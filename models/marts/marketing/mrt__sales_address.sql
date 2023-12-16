with 

int_order_items as (
    select * from {{ ref('int__order_items')}}
),

int_full_products as (
    select * from {{ ref('int__full_products')}}
),

int_address as (
    select * from {{ ref('int__addresses')}}
),

int_persons as (
    select * from {{ ref('int__persons')}}
    where customer_id != 'no_customer'
),


fct_sales_address_casted as (

    select
        distinct(concat(d.city, ' - ' ,d.state))    as address,
        count(distinct b.customer_id)               as total_customer_attended_by_address,
        count(distinct b.order_id)                  as total_orders_ordered_by_address,
        round(sum(final_price),2)                   as total_price_payed_by_address,
        round(avg(final_price),2)                   as average_price_payed_by_address,
        count(b.product_id)                         as total_products_ordered_by_address,
        round(avg(b.discount_rate),4)               as average_discount_by_address,        
        count(distinct model)                       as distinct_models_buyed_by_address,
        count(distinct c.brand_id)                  as distinct_brands_buyed_by_address,
        count(distinct c.category_id)               as distinct_categories_buyed_by_address,
        avg(shipped_date_utf-order_date_utf)        as average_time_order_to_shipped
 
    from int_order_items b
    inner join int_full_products c on b.product_id=c.product_id
    inner join int_persons e on b.customer_id=e.customer_id
    inner join int_address d on e.address_id=d.address_id
    group by concat(d.city, ' - ' ,d.state)

)

select * from fct_sales_address_casted
order by total_price_payed_by_address desc