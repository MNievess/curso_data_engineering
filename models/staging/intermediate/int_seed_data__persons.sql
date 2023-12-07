with 

_staff as (
    select * from {{ ref('stg_seed_data__staff') }}
),

_customer as (
    select * from {{ ref('stg_seed_data__customer') }}
),


base_stores_casted as (

    select
        street,
        city,
        state,
        zip_code

    from _stores
),

base_customer_casted as (

    select
        street,
        city,
        state,
        zip_code

    from _orders
)



select * from base_customer_casted
union all
select * from base_stores_casted
