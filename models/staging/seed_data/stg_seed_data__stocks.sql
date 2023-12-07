with src_stocks as (

    select * from {{ source('seed_data', 'stocks') }}
),

src_stocks_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['store_id'])}}::varchar(50) as store_id,
        {{dbt_utils.generate_surrogate_key(['product_id'])}}::varchar(50) as product_id,
        quantity::number(38,0) as quantity_stock

    from src_stocks

)

select * from src_stocks_casted
