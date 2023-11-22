{{ config(
    
  materialized='view'
  
) }}


with src_promos as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

stg_promos as (
    select
        cast({{dbt_utils.generate_surrogate_key(["promo_id"])}} as varchar(50)) as promo_id,
        cast(promo_id as varchar(50)) as promo_name,
        discount::number(38,0) as discount_usd,
        status::varchar(50) as promo_status,
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

SELECT  {{dbt_utils.generate_surrogate_key(['9999'])}} as promo_id,
        'no-promo' as promo_name, 
        '0' as discount_usd, 
        'inactive' as promo_status
