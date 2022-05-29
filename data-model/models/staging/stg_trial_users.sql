SELECT user_id, count(*) as number_of_trials_taken
  FROM {{ref('stg_workspace_monthly_charges')}}
  where is_trial=true
  group by 1