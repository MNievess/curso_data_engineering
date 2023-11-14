with 

src_promos as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

src_promos_casted as (

    select
        promo_id,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from src_promos

)

select * from src_promos_casted
