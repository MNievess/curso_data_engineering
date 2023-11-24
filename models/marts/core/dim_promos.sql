with 

src_dim_promos as (

    select * from {{ ref('stg_sql_server_dbo_promos') }}

),

src_dim_promos_casted as (

    select distinct
        promo_id,
        promo_name,
        discount_usd,
        promo_status,
        --_fivetran_deleted,
        date_load
    from src_dim_promos
)

select * from src_dim_promos_casted
