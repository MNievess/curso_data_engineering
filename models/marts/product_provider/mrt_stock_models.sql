with 

fct_stocks as (
    select * from {{ ref('stg_seed_data__stocks') }}
),

fct_products as (
    select * from {{ ref('int__full_products') }}
),


fct_stocks_metrics3_casted as (

    select
        product_full_name,
        count(a.product_id) as total_products_by_model,
        count (distinct store_id) as total_stores_have_model
     
        
    from fct_stocks a
    inner join fct_products b on a.product_id=b.product_id
    group by product_full_name

)

select * from fct_stocks_metrics3_casted
order by count_products_by_model desc