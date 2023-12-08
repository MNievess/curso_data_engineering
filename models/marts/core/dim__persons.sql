with

_staff as (
    select * from {{ ref('stg_seed_data__staff') }}
),

_customer as (
    select * from {{ ref('stg_seed_data__customer') }}
),


base_staff_casted as (

    select
        first_name,
        last_name,
        full_name,
        phone_number,
        email,
        {{dbt_utils.generate_surrogate_key(['null'])}}::varchar(50) as address_id,
        staff_id,
        store_id,
        manager_id,
        staff_active_inactive

    from _staff
),

base_customer_casted as (

    select
        first_name,
        last_name,
        full_name,
        phone_number,
        email,
        {{dbt_utils.generate_surrogate_key(['street','city','state','zip_code'])}}::varchar(50) as address_id,
        null as staff_id,
        null as store_id,
        null as manager_id,
        null as staff_active_inactive

    from _customer
)


select * from base_staff_casted
union all
select * from base_customer_casted


