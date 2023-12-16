with 

fct_stocks as (
    select * from {{ ref('stg_seed_data__stocks') }}
),

fct_int_time as (
    select * from {{ ref('stg_auxiliary__time_day')}}
),


fct_orders_casted1 as (

    select
        {{dbt_utils.generate_surrogate_key(['store_id','product_id'])}}::varchar(50) as stock_id,
        store_id,
        to_date(GETDATE()) as updated_at,
        product_id,
        quantity_stock as quantity_total_stock
        
    from fct_stocks 

),

fct_orders_casted2 as (

    select
        stock_id,
        store_id,
        updated_at,
        product_id,
        quantity_total_stock
        
    from fct_orders_casted1 a
    inner join fct_int_time b on a.updated_at=b.date_day

)


select * from fct_orders_casted2