with src_base_addresses as (

    select * from {{ source('sql_server_dbo','addresses') }}

),

src_base_addresses_casted as (
    select
        address_id::varchar(50) as address_id,
        concat(address, ' ',zipcode,' ',country,' ',state) as full_address,
        address::varchar(150) as address,
        zipcode::number(38,0) as zipcode,
        country::varchar(50) country,
        state::varchar(50)as state,
        --coordenates
        _fivetran_deleted::boolean as _fivetran_deleted,
        _fivetran_synced::timestamp_ntz as date_load
    from src_base_addresses
)

select * from src_base_addresses_casted