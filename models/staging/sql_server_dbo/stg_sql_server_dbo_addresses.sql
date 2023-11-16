with src_addresses as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

src_addresses_casted as (
    select
        address_id::varchar(50) as address_id,
        zipcode::number(38,0) as zipcode,
        country::varchar(50) country,
        address::varchar(150) address,
        state::varchar(50)as state,
        _fivetran_deleted::boolean as _fivetran_deleted,
        _fivetran_synced::timestamp_ntz as date_load
    from src_addresses
)

select * from src_addresses_casted
