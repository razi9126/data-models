SELECT 
  sb.subscription_period_id,
  sb.workspace_id,
  sb.is_trial,
  sb.charge_month,
  sb.started_on,
  sb.finished_on,
  sb.user_count as sub_user_count,
  ch.pricing_plan_id,
  ch.amount_usd,
  ch.user_count as charges_user_count,
 from {{ref('base_subscription_periods')}} sb 
  left join {{ source('sources', 'charges') }} ch 
  on sb.charge_month = ch.charge_month 
  and sb.workspace_id =ch.workspace_id 