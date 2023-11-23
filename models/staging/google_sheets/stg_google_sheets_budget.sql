with src_budget as (

    select * from {{ source('google_sheets', 'budget') }}

),

src_budget_casted as (
    select
        _row as _row,
        quantity::number(38,0) as quantity,
        --year(_month)*100+month(_month) as id_anio_mes
        --to_year(month) as _month
        --datepart(month, month) as _month,
        --datepart(year, month) as _year,
        --month(month, GETDATE()) AS Mes
        month as month_and_year,
        --as month_year
        product_id::varchar(50) as product_id,
        _fivetran_synced::timestamp_ntz as date_load
    from src_budget
)

select * from src_budget_casted

