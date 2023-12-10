with base_orders as (
    select * from {{ source('seed_data', 'orders') }}
),

base_orders_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['order_id'])}}::varchar(50) as order_id,
        {{dbt_utils.generate_surrogate_key(['customer_id'])}}::varchar(50) as customer_id,
        {{dbt_utils.generate_surrogate_key(['store_id'])}}::varchar(50) as store_id,
        {{dbt_utils.generate_surrogate_key(['staff_id'])}}::varchar(50) as staff_id,
        order_date::date as order_date_utf,
        required_date::date as required_date_utf,
        shipped_date::date as shipped_date_utf,
        cast(case when order_status = 1 then 'pending'
            when order_status = 2 then 'processing'
            when order_status = 3 then 'rejected'
            when order_status = 4 then 'processed' end as varchar(50)) as status_order

    from base_orders
),

base_orders_casted2 as (

    select

        order_id,
        customer_id,
        store_id,
        staff_id,
        order_date_utf,
        required_date_utf,
        shipped_date_utf,
        lower(status_order) as status_order,
        {{dbt_utils.generate_surrogate_key(['status_order'])}}::varchar(50) as status_order_id

    from base_orders_casted
)

select * from base_orders_casted2