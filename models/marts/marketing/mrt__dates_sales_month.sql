with 

int_order_items as (
    select * from {{ ref('int__order_items')}}
),

int_dates as (
    select * from {{ ref('stg_auxiliary__time_day')}}
),


mrt_dates_sales_year_casted as (

    select
        
        distinct f.month_year as month_year,
        sum(b.final_price) as sales_by_month,
        count(b.product_id) as products_sold_by_month,
        count(distinct b.order_id) as orders_sold_by_month,
        count(distinct b.customer_id) as customer_attended_by_month

    from int_order_items b
    inner join int_dates f on b.order_date_utf=f.date_day

    group by month_year

)

select * from mrt_dates_sales_year_casted
order by month_year asc