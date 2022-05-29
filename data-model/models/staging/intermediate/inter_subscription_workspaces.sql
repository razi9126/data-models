select sub_charges.subscription_period_id,
sub_charges.workspace_id,
sub_charges.is_trial,
sub_charges.charge_month,
sub_charges.started_on,
sub_charges.finished_on,
sub_charges.sub_user_count as user_count,
sub_charges.pricing_plan_id,
if(sub_charges.amount_usd is null, 0, sub_charges.amount_usd) as amount_usd,
ws.user_id as user_id,
ws.country_id,
ws.created_at
from {{ref('inter_subscription_charges')}} sub_charges
left join {{ref('base_workspaces')}} ws
on sub_charges.workspace_id=ws.workspace_id