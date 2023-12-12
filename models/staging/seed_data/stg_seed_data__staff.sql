with 

src_staff as (

    select * from {{ ref('base_seed_data__staff') }}

),

src_staff_casted1 as (

    select
        {{dbt_utils.generate_surrogate_key(['staff_id'])}}::varchar(50) as staff_id,
        first_name::varchar(50) as first_name,
        last_name::varchar(50) as last_name,
        concat(last_name,', ',first_name)::varchar(50) as full_name,
        email::varchar(50) as email,
        cast(replace(replace(replace(replace(phone,'-',''),' ',''),'(',''),')','') as varchar(15)) as phone_number,
        active::varchar() as staff_active_inactive,
        {{dbt_utils.generate_surrogate_key(['store_id'])}}::varchar(50) as store_id,
        manager_id::varchar(50) as manager_id


    from src_staff

),

src_staff_casted2 as (

    select
        staff_id,
        first_name,
        last_name,
        full_name,
        email,
        case 
            when phone_number is not null then phone_number
            when phone_number is null then '###' end as phone_number,
        case    
            when staff_active_inactive = 1 then 'active'
            when staff_active_inactive = 2 then 'inactive'
            end as staff_active_inactive,
        store_id,
        case 
            when manager_id is null then {{dbt_utils.generate_surrogate_key(['null'])}}
            when manager_id is not null then {{dbt_utils.generate_surrogate_key(['manager_id'])}} end as manager_id

    from src_staff_casted1

)

select * from src_staff_casted2
union all
select
    {{dbt_utils.generate_surrogate_key(['null'])}} staff_id,
    'nobody' first_name,
    'nobody' last_name,
    'nobody' full_name,
    'nobody' email,
    'nobody' phone_number,
    'nobody' staff_active_inactive,
    'nobody' store_id,
    'nobody' manager_id


