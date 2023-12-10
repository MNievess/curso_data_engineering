with base_stores as (

    select * from {{ source('seed_data', 'stores') }}

),

base_stores_casted as (

    select
        {{dbt_utils.generate_surrogate_key(['store_id'])}}::varchar(50) as store_id,
        store_name::varchar(100) as store_name,
        cast(replace(replace(replace(replace(phone,'-',''),' ',''),'(',''),')','') as number(15,0)) as phone_number,
        email::varchar(50) as store_email,
        street::varchar(50) as street,
        city::varchar(50) as city,
        state::varchar(50) as state,
        zip_code::varchar(10) as zip_code

    from base_stores

)

select * from base_stores_casted