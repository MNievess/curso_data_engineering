
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
        cast(updated_at as timestamp_ntz) as updated_at,
        address_id::varchar(50) as address_id,
        last_name::varchar(50) as last_name,
        created_at::timestamp_ntz as created_at,
        phone_number::varchar(20) as phone_number,
        total_orders::number(38,0) as total_orders,
        first_name::varchar(50) as first_name,
        email::varchar(100) as email,
        _fivetran_deleted::boolean as _fivetran_deleted,
        _fivetran_synced::timestamp_ntz as date_load
    FROM src_users
    )

SELECT * FROM src_users_casted


