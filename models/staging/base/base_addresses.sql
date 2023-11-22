with src_base_addresses as (

    select * from {{ source('sql_server_dbo','addresses') }}

),

src_base_addresses_casted as (
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
    from src_base_addresses
)

select * from src_base_addresses_casted