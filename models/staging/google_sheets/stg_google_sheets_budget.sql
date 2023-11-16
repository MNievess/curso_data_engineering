with src_budget as (

    select * from {{ source('google_sheets', 'budget') }}

),

src_budget_casted as (
    select
        _row,
        quantity,
        month,
        product_id,
        _fivetran_synced::timestamp_ntz as date_load
    from src_budget
)

select * from src_budget_casted
