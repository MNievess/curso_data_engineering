{% snapshot snapshot_stg_staff %}

{{
    config(
      target_schema='snapshots',
      unique_key='staff_id',
      strategy='check',
      check_cols=['staff_id','first_name','last_name','email','phone_number','active','store_id','manager_id'],
      invalidate_hard_deletes=True,

        )
}}

select * from {{ ref('stg_seed_data__staff') }}

{% endsnapshot %}