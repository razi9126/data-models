with payments_user as(
    Select * from {{ref('inter_payment_users')}}
),
pricing as (
    select * from {{ source('sources', 'pricing_plans') }}
),
reactivated_workspaces as (
    select * from {{ref('stg_reactivated_workspaces')}}

),
new_workspaces as (
    select * from {{ref('stg_new_workspaces')}}

)
select
payments_user.charge_month,
payments_user.user_id,
payments_user.workspace_id,
payments_user.subscription_period_id,
payments_user.pricing_plan_id,
pricing.plan_name,
pricing.plan_period,
payments_user.medium,
payments_user.source,
payments_user.campaign,
payments_user.is_trial,
payments_user.user_count,
payments_user.amount_usd,
if(reactivated_workspaces.workspace_id is null, false, true) as is_reactivated,
if(new_workspaces.workspace_id is null, false, true) as is_new,
payments_user.started_on,
payments_user.finished_on
from payments_user
left join pricing on payments_user.pricing_plan_id=pricing.pricing_plan_id
left join reactivated_workspaces on payments_user.workspace_id=reactivated_workspaces.workspace_id and payments_user.charge_month=reactivated_workspaces.charge_month
left join new_workspaces on payments_user.workspace_id=new_workspaces.workspace_id and payments_user.charge_month=new_workspaces.charge_month
order by workspace_id,charge_month
