 
{% set event_types = is_incremental() %}

{{
  config(
    materialized='incremental'
  )
}}


with src_increm_users as (

    select * from {{ source('sql_server_dbo', 'users') }}

    {% if is_incremental() %}

	    where _fivetran_synced > (select max(f_carga) from {{ this }})

    {% endif %}

),

src_users_casted as (

    select
        user_id::varchar(50) as user_id,
        first_name::varchar(50) as first_name,
        last_name::varchar(50) as last_name,
        address_id::varchar(50) as address_id,
        replace(phone_number, '-','')::number(20) as phone_number,
        --concat(left(phone_number,3), left(right(phone_number,8),3), right(phone_number,4))::number(20) as phone_number,
        _fivetran_synced::timestamp_ntz as f_carga

    from src_increm_users

)

select * from src_users_casted
