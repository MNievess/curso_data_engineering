with 

src_stores as (

    select * from {{ ref('stores_snapshot') }}

),

src_stores_casted as (

    select
        store_id,
        store_name,
        phone_number,
        store_email,
        street,
        city,
        state,
        zip_code

    from src_stores

)

select * from src_stores_casted
