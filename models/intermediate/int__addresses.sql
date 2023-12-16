with 

_stores as (
    select * from {{ ref('stg_seed_data__stores') }}
),

_customer as (
    select * from {{ ref('stg_seed_data__customer') }}
),


base_stores_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['street','city','state','zip_code'])}}::varchar(50) as address_id,
        street,
        city,
        state,
        zip_code

    from _stores
),

base_customer_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['street','city','state','zip_code'])}}::varchar(50) as address_id,
        street,
        city,
        state,
        zip_code

    from _customer
)

select * from base_customer_casted
union all
select * from base_stores_casted
