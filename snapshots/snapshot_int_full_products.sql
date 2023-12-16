{% snapshot snapshot_int_full_products %}

{{
    config(
      target_schema='snapshots',
      unique_key='product_id',
      strategy='check',
      check_cols=['product_id','product_full_name','brand_id','brand','model','model_year','category_id','category','list_price_usd'],        
      invalidate_hard_deletes=True

        )
}}

select * from {{ ref('int__full_products') }}

{% endsnapshot %}