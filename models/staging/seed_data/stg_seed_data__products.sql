with src_products as (

    select * from {{ ref('base_seed_data__products') }}

),

src_products_casted as (

    select
        product_id,
        product_name,
        brand_id,
        model_year,
        category_id,
        list_price_usd

    from src_products

)

select * from src_products_casted



