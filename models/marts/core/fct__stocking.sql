with 

fct_stocks as (
    select * from {{ ref('stg_seed_data__stocks') }}
),


fct_orders_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['store_id','product_id'])}}::varchar(50) as stock_id,
        store_id,
        to_date(GETDATE()) as updated_at,
        product_id,
        quantity_stock as quantity_total_stock
        
        
    from fct_stocks

)

select * from fct_orders_casted