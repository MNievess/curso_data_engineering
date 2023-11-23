WITH stg_users1 AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo_users') }}
    ),

    stg_addresses1 AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo_addresses') }}
    ),

renamed_casted AS (
    SELECT
        user_id,
        updated_at,
        last_name,
        created_at,
        phone_number,
        total_orders,
        first_name,
        email,
        a.address_id,
        zipcode,
        country,
        address,
        state
        
    FROM stg_users1 u
    join stg_addresses1 a on u.address_id=a.address_id
    )

SELECT * FROM renamed_casted