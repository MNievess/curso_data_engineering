with base_customer as (

    select * from {{ source('seed_data', 'customer') }}

),

base_customer_casted1 as (

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

    from base_customer

),

base_customer_casted2 as (

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
    from base_customer_casted1

)

select * from base_customer_casted2