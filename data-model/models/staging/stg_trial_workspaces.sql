SELECT workspace_id
  FROM {{ref('stg_workspace_monthly_charges')}} 
  where is_trial=true
  group by 1