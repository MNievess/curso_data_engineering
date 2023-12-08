with 

fct_orders as (
    select * from {{ ref('stg_seed_data__orders')}}
),

fct_order_items as (
    select * from {{ ref('stg_seed_data__order_items')}}
),



fct_sales_customer_casted as (

    select
        a.customer_id,
        --(select order_date_utf from fct_sub_sales order by order_date_utf desc) as last_order_date_utf,
        round(sum(final_price),2) as total_price_payed,
        count(b.product_id) as total_orders_products
        
    from fct_orders a
    inner join fct_order_items b on a.order_id=b.order_id
    group by a.customer_id

)

select * from fct_sales_customer_casted