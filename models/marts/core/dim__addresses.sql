with 

_address as (
    select * from {{ ref('int__addresses') }}
),


base_address_casted as (

    select
        address_id,
        street,
        city,
        state,
        zip_code

    from _address
)

select * from base_address_casted
