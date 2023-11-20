{{ config(
    
  materialized='view'
  
) }}


with src_promos as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

stg_promos as (
    select
        {{dbt_utils.generate_surrogate_key(["promo_id"])}} as promo_id,
        UPPER(promo_id) as promo_name,
        discount as discount_usd,
        status as promo_status,
        _fivetran_synced as date_load
    from src_promos
)

select 
    {{dbt_utils.generate_surrogate_key(["promo_id"])}} as promo_id,
    promo_name,
    discount_usd,
    promo_status
    
from stg_promos

union all 

SELECT  '9999' as promo_id,
        'SIN PROMO' as promo_name, 
        '0' as discount, 
        'Inactive' as promo_status
