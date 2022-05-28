with payments_raw as(
  SELECT mc.*,
  us.medium,
  us.source
  FROM {{ref('stg_user_monthly_charges')}}  mc
  left join {{ref('users')}}  us on mc.user_id=us.user_id
)
select
charge_month,
user_id,
workspace_id,
subscription_period_id,
pricing_plan_id,
medium,
source,
is_trial,
user_count,
amount_usd,
started_on,
finished_on
from payments_raw
order by charge_month
