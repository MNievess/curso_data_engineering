with base_staff as (

    select * from {{ source('seed_data', 'staff') }}

),

base_staff_casted as (

    select
        staff_id,
        first_name,
        last_name,
        email,
        phone,
        active,
        store_id,
        manager_id

    from base_staff

)

select * from base_staff_casted