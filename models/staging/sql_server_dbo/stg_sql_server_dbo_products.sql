
{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

src_products_casted AS (
    SELECT
        product_id::varchar(50),
        price::float,
        name::varchar(100),
        inventory::number(38,0),
        _fivetran_deleted::boolean,
        _fivetran_synced::timestamp_ntz(9) as date_load
    FROM src_products
    )

SELECT * FROM src_products_casted