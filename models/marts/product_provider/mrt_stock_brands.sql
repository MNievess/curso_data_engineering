with 

fct_stocks as (
    select * from {{ ref('stg_seed_data__stocks') }}
),

fct_products as (
    select * from {{ ref('int__full_products') }}
),


fct_stocks_metrics_casted as (

    select
        brand_id,
        count (distinct model) as total_models_by_brand,
        count (distinct store_id) as total_stores_have_brand,
        count (distinct category_id) as total_categories_by_brand
    
        
        
    from fct_stocks a
    inner join fct_products b on a.product_id=b.product_id
    group by brand_id

)

select * from fct_stocks_metrics_casted