with ws as
(
  SELECT * from {{ref('base_workspaces')}}
),
total as (
  SELECT user_id,
  sum(amount_usd) as total_amount_spent
  FROM {{ref('stg_user_monthly_charges')}} 
  group by 1
),
trial as(
  SELECT user_id 
  FROM {{ref('stg_user_monthly_charges')}} 
  where is_trial=true
),
user_count as(
    SELECT user_id,
    max(user_count) as max_workspace_users,
    min(user_count) as min_workspace_users,
    FROM {{ref('stg_user_monthly_charges')}}
    group by 1
),
attr as (
  select *
  from {{ref('stg_user_first_attribution')}} 
)

select ws.user_id,
ws.workspace_id,
ws.country_id,
ws.created_at,
if(total.total_amount_spent is null, 0, total.total_amount_spent) as total_amount_spent,
attr.source,
attr.medium,
if(trial.user_id is null, false, true) as trial_taken,
if(user_count.max_workspace_users is null, 1, user_count.max_workspace_users) as max_workspace_users,
if(user_count.min_workspace_users is null, 1, user_count.min_workspace_users) as min_workspace_users,
from  ws
left join total on ws.user_id= total.user_id
left join attr on ws.user_id= attr.user_id
left join trial on ws.user_id= trial.user_id
left join user_count on ws.user_id= user_count.user_id
