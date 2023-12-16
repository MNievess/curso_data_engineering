with

_staff as (
    select * from {{ ref('stg_seed_data__staff') }}
),

_customer as (
    select * from {{ ref('stg_seed_data__customer') }}
),


base_staff_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['first_name','last_name','phone_number','email'])}}::varchar(50) as person_id,
        'no_customer' as customer_id,
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
        {{dbt_utils.generate_surrogate_key(['first_name','last_name','phone_number','email'])}}::varchar(50) as person_id,
        customer_id,
        first_name,
        last_name,
        full_name,
        phone_number,
        email,
        {{dbt_utils.generate_surrogate_key(['street','city','state','zip_code'])}}::varchar(50) as address_id,
        'no_staff' as staff_id,
        'no_staff' as store_id,
        'no_staff' as manager_id,
        'no_staff' as staff_active_inactive

    from _customer
)


select * from base_staff_casted
union all
select * from base_customer_casted


