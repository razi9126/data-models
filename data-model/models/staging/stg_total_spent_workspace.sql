SELECT workspace_id,
  sum(amount_usd) as total_amount_spent
  FROM {{ref('stg_workspace_monthly_charges')}} 
  group by 1