{% snapshot snapshot_incremental %}

{{
    config(
      target_schema='snapshots',
      unique_key='user_id',
      strategy='check',
      check_cols=['first_name','last_name','address_id','phone_number'],
    )
}}

select * from {{ ref('stg_incremental_users') }}
where f_carga = (select max(f_carga) from stg_incremental_users)  --Esta frase es la que indica a dbt que este snapshot es incremental

{% endsnapshot %}