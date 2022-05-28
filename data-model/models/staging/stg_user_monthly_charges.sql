with data as 
(
  Select * from {{ref('inter_subscription_charges')}}
)

select d.subscription_period_id,
d.workspace_id,
d.is_trial,
d.charge_month,
d.started_on,
d.finished_on,
d.sub_user_count as user_count,
d.pricing_plan_id,
d.amount_usd,
us.owner_user_id as user_id
from data d
left join {{ source('sources', 'workspaces') }} us
on d.workspace_id=us.workspace_id
where d.sub_user_count = d.charges_user_count  
and d.amount_usd is not null

