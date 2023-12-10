{% snapshot stores_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='store_id',
      strategy='check',
      check_cols=['store_id','store_name','phone_number','email','street','city','state','zip_code'],
      invalidate_hard_deletes=True,

        )
}}

select * from {{ ref('base_seed_data__stores') }}

{% endsnapshot %}