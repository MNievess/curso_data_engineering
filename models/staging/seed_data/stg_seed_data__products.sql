with src_products as (

    select * from {{ source('seed_data', 'products') }}

),

src_products_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['product_id'])}}::varchar(50) as product_id,
        product_name::varchar(100) as product_name,
        {{dbt_utils.generate_surrogate_key(['brand_id'])}}::varchar(50) as brand_id,
        model_year::number(4,0) as model_year,
        {{dbt_utils.generate_surrogate_key(['category_id'])}}::varchar(50) as category_id,
        list_price::number(38,2) as list_price_$

    from src_products

)

select * from src_products_casted



