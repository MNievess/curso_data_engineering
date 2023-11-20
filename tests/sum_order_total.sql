{% test sum_order_total() %}

select a.order_id, 
    a.order_cost, 
    a.shipping_cost, 
    a.order_total, 
    b.discount,
    round((a.order_cost+a.shipping_cost-b.discount),2) as total_and_discount
from stg_sql_server_dbo_orders a
    join stg_sql_server_dbo__promos b on a.promo_id=b.promo_id
    where total_and_discount <> a.order_total

{% endtest %}

