with 

src_customer as (

    select * from {{ ref('base_seed_data__customer') }}

),

src_customer_casted1 as (

    select
        customer_id,
        first_name,
        last_name,
        full_name,
        phone_number,
        email,
        street,
        city,
        state,
        zip_code

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
