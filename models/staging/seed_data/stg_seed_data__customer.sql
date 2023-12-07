with 

src_customer as (

    select * from {{ ref('base_seed_data__customer') }}

),

src_customer_casted1 as (

    select
        {{dbt_utils.generate_surrogate_key(['customer_id'])}}::varchar(50) as customer_id,
        first_name::varchar(50) as first_name,
        last_name::varchar(50) as last_name,
        concat(last_name,', ',first_name) as full_name,
        cast(replace(replace(replace(replace(phone,'-',''),' ',''),'(',''),')','') as varchar(15)) as phone_number,
        email::varchar(50) as email,
        street::varchar(100) as street,
        city::varchar(50) as city,
        state::varchar(50) as state,
        zip_code::varchar(10) as zip_code

    from src_customer

),

src_customer_casted2 as (

    select
        customer_id,
        first_name,
        last_name,
        full_name,
        case 
            when phone_number is not null then phone_number
            when phone_number is null then '###' end as phone_number,
        email,
        street,
        city,
        state,
        zip_code
    from src_customer_casted1

)

select * from src_customer_casted2
