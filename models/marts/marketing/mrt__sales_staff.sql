with 

fct_orders_staff as (
    select * from {{ ref('stg_seed_data__orders')}}
),

fct_order_items_staff as (
    select * from {{ ref('stg_seed_data__order_items')}}
),

int_full_products as (
    select * from {{ ref('int__full_products')}}
),



fct_sales_staff_casted as (

    select
        a.staff_id as employed_id,
        round(sum(final_price),2) as total_price_earned_by_employed,
        count(b.product_id) as total_products_sold_by_employed,
        count(distinct model) as distinct_models_sold_by_employed,
        count(distinct c.brand_id) as distinct_brands_sold_by_employed,
        count(distinct b.order_id) as total_orders_ordered_by_employed,
        count(a.customer_id) as total_customer_attended_by_employed,
        round(avg(order_item_discount_rate),4) as average_discount_by_employed
        
    from fct_orders_staff a
    full join fct_order_items_staff b on a.order_id=b.order_id
    inner join int_full_products c on b.product_id=c.product_id
    group by a.staff_id

)

select * from fct_sales_staff_casted
order by total_price_earned_by_employed desc