{% snapshot products_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='product_id',
      strategy='check',
      check_cols=['product_id','product_name','brand_id','model_year','category_id','list_price_usd'],
      invalidate_hard_deletes=True

        )
}}

select * from {{ ref('base_seed_data__products') }}

{% endsnapshot %}