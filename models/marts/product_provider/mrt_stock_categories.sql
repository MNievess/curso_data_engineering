with 

fct_stocks as (
    select * from {{ ref('stg_seed_data__stocks') }}
),

fct_products as (
    select * from {{ ref('int__full_products') }}
),


fct_stocks_metrics2_casted as (

    select
        category_id,
        count (distinct model) as total_models_by_category,
        count (distinct store_id) as total_stores_have_category,
        count (distinct brand_id) as total_brands_by_category
    
        
        
    from fct_stocks a
    inner join fct_products b on a.product_id=b.product_id
    group by category_id

)

select * from fct_stocks_metrics2_casted