with

_store as (
    select * from {{ ref('stg_seed_data__stores') }}
),


dim_store_casted as (

    select
        store_id,
        store_name,
        phone_number,
        store_email

    from _store
)

select * from dim_store_casted