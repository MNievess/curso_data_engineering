with base_stores as (

    select * from {{ source('seed_data', 'customer') }}

),

base_stores_casted as (

    select


    from base_stores

)

select * from base_stores_casted