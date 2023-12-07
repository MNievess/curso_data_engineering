with src_brands as (

    select * from {{ source('seed_data', 'brands') }}

),

src_brands_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['brand_id'])}}::varchar(50) as brand_id,
        brand_name::varchar(50) as brand_name

    from src_brands

)

select * from src_brands_casted
