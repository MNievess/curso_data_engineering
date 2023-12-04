with src_addresses as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

src_addresses_casted as (
    select
        address_id,
        --full_address,
        address,
        zipcode,
        country,
        state,
        --coordenates
        _fivetran_deleted,
        _fivetran_synced as date_load
    from src_addresses
)

select * from src_addresses_casted

