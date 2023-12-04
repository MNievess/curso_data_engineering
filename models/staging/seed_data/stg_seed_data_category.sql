with 

src_category as (

    select * from {{ source('seed_data', 'category') }}

),

src_category_casted as (

    select

        category_id,
        employee_id,
        category_name,
        rating,
        quantity_sold,
        being_manufactured,
        total_sold_value

    from src_category

)

select * from src_category_casted
