{% snapshot snapshot_stg_customer %}

{{
    config(
      target_schema='snapshots',
      unique_key='customer_id',
      strategy='check',
      check_cols=['customer_id','first_name','last_name','email','phone_number','street','city','state','zip_code'],
      invalidate_hard_deletes=True,

        )
}}

select * from {{ ref('stg_seed_data__customer') }}

{% endsnapshot %}