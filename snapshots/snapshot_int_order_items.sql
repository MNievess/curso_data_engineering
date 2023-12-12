{% snapshot snapshot_int_order_items %}

{{
    config(
      target_schema='snapshots',
      unique_key='product_id' and 'order_id',
      strategy='check',
      check_cols=['order_id',
                'customer_id',
                'store_id',
                'staff_id',
                'status_order_id',
                'status_order',
                'order_date_utf',
                'required_date_utf',
                'shipped_date_utf',
                'product_id',
                'item_id',
                'order_item_quantity',
                'list_price_usd',
                'discount_id',
                'discount_rate'],
      invalidate_hard_deletes=True

        )
}}

select * from {{ ref('int__order_items') }}

{% endsnapshot %}