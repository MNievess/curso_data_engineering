
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
        product_id::varchar(50) as product_id,
        price::float as price_usd,
        name::varchar(100) as product_name,
        inventory::number(38,0) as inventory,
        _fivetran_deleted::boolean as _fivetran_deleted,
        _fivetran_synced::timestamp_ntz(9) as date_load
    FROM src_products
    )

SELECT * FROM src_products_casted

SELECT * from stg_sql_server_dbo_products