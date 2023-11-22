
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

--SELECT * FROM src_products_casted

SELECT
    product_id,
    price_usd,
    product_name,
    inventory
    
from src_products_casted

union all 

SELECT  {{dbt_utils.generate_surrogate_key(['9999'])}},
        '0.0', 
        'no_product', 
        '0'
