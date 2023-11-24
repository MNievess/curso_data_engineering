
{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

src_users_casted AS (
    SELECT
        user_id::varchar(50) as user_id,
        first_name::varchar(50) as first_name,
        last_name::varchar(50) as last_name,
        concat(last_name,', ',first_name) as full_name,
        replace(phone_number,'-','')::varchar(20) as phone_number,
        address_id::varchar(50) as address_id,
        email::varchar(100) as email,
        to_date(created_at) as date_created_at_utc,
        to_time(created_at) as time_created_at_utc,
        created_at as full_created_at,
        to_date(updated_at) as date_updated_at_utc,
        to_time(updated_at) as time_updated_at_utc,
        updated_at as full_updated_at,
        --total_orders::number(38,0) as total_orders,
        _fivetran_deleted::boolean as _fivetran_deleted,
        _fivetran_synced::timestamp_ntz as date_load
    FROM src_users
    )

SELECT * FROM src_users_casted


