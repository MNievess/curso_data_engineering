WITH stg_users1 AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo_users') }}
    ),

    stg_addresses1 AS (
    SELECT *
    FROM {{ ref('stg_sql_server_dbo_addresses') }}
    ),

complex_users_renamed_casted AS (
    SELECT
        user_id,
        first_name,
        last_name,
        full_name,
        phone_number,
        email,
        a.address_id,
        full_address,
        address,
        zipcode,
        country,
        state,
        date_created_at_utc,
        time_created_at_utc,
        full_created_at,
        date_updated_at_utc,
        time_updated_at_utc,
        full_updated_at

    FROM stg_users1 u
    join stg_addresses1 a on u.address_id=a.address_id
    )

SELECT * FROM complex_users_renamed_casted