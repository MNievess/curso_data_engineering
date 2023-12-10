with int_products as (
    select * from {{ ref('stg_seed_data__products') }}
),

int_brands as (
    select * from {{ ref('stg_seed_data__brands') }}
),

int_categories as (
    select * from {{ ref('stg_seed_data__categories') }}
),

int_products_casted as (

    select
        a.product_id,
        a.product_name as product_full_name,
        a.brand_id,
        b.brand_name as brand,
        replace(SUBSTRING(product_name, 1, CHARINDEX(' - ', product_name) - 1),brand_name,'') as model,
        model_year,
        a.category_id,
        category_name as category,
        list_price_$

    from int_products a
    full join int_brands b on a.brand_id=b.brand_id
    full join int_categories c on a.category_id=c.category_id

)

select * from int_products_casted
order by brand


