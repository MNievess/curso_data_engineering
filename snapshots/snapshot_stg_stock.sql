{% snapshot snapshot_stg_stock %}

{{
    config(
      target_schema='snapshots',
      unique_key='store_id' and 'product_id',
      strategy='check',
      check_cols=['store_id','product_id','quantity_stock'],
      invalidate_hard_deletes=True,

        )
}}

select * from {{ ref('stg_seed_data__stocks') }}

{% endsnapshot %}