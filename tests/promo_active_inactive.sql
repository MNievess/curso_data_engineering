{% test promo_active_inactive() %}

select *
from stg_sql_server_dbo__promos
where status not like 'active' and status not like 'inactive' 

{% endtest %}

