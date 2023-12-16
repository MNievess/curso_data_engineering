with

_person as (
    select * from {{ ref('int__persons') }}
),


_person_casted as (

    select
        person_id,
        customer_id,
        first_name,
        last_name,
        full_name,
        phone_number,
        email,
        address_id,
        staff_id,
        store_id,
        manager_id,
        staff_active_inactive

    from _person
)


select * from _person_casted




