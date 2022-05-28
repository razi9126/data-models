with data as 
(
  Select * from {{ref('inter_subscription_charges')}}
),
temp as(
select d.subscription_period_id,
d.workspace_id,
d.is_trial,
d.charge_month,
d.started_on,
d.finished_on,
d.sub_user_count as user_count,
d.pricing_plan_id,
if(d.amount_usd is null, 0, d.amount_usd) as amount_usd,
us.user_id as user_id
from data d
left join {{ref('base_workspaces')}} us
on d.workspace_id=us.workspace_id
)
select * from temp where user_id is not null