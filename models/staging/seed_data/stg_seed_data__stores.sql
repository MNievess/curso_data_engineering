with 

src_stores as (

    select * from {{ ref('base_seed_data__stores') }}

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
