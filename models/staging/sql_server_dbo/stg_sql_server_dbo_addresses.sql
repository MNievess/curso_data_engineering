with src_addresses as (

    select * from {{ ref('base_addresses') }}

),

src_addresses_casted as (
    select
        address_id,
        full_address,
        address,
        zipcode,
        country,
        state,
        --coordenates
        _fivetran_deleted,
        date_load
    from src_addresses
)

select * from src_addresses_casted

