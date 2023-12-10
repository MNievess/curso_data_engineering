with dim_products as (
    select * from {{ ref('int__full_products') }}
),


dim_products_casted as (

    select
        product_id,
        product_full_name,
        brand,
        model,
        model_year,
        category,
        list_price_usd

    from dim_products

)

select * from dim_products_casted
order by brand





