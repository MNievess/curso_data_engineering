with 

int_order_items as (
    select * from {{ ref('int__order_items')}}
),

int_dates as (
    select * from {{ ref('stg_auxiliary__time_day')}}
),


mrt_dates_sales_year_casted as (

    select
        
        distinct f.date_day as date_day,
        sum(b.final_price) as sales_by_day,
        count(b.product_id) as products_sold_by_day,
        count(distinct b.order_id) as orders_sold_by_day,
        count(distinct b.customer_id) as customer_attended_by_day

    from int_order_items b
    inner join int_dates f on b.order_date_utf=f.date_day
    group by date_day

)

select * from mrt_dates_sales_year_casted
order by date_day asc