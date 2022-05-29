SELECT mc.*,
us.medium,
us.source,
us.campaign,
FROM {{ref('stg_workspace_monthly_charges')}}  mc
left join {{ref('stg_user_first_attribution')}}  us on mc.user_id=us.user_id
  