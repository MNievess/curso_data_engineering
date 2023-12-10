with 

src_discount_orders as (

    select * from {{ ref('stg_seed_data__order_items') }}

),

src_discount_orders_casted as (

    select distinct
        
        discount_rate::number(38,2) as discount_rate,
        {{dbt_utils.generate_surrogate_key(['discount_rate'])}}::varchar(50) as discount_id
        
    from src_discount_orders
    --order by discount_rate desc

)

select * from src_discount_orders_casted