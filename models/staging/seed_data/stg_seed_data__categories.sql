with src_categories as (

    select * from {{ source('seed_data', 'categories') }}

),

src_categories_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['category_id'])}}::varchar(50) as category_id,
        category_name::varchar(50) as category_name
        
    from src_categories

)

select * from src_categories_casted
