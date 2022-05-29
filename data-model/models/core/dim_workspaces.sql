with workspaces as
(
  SELECT * from {{ref('base_workspaces')}}
),
total_spent_workspace as (
  SELECT * from {{ref('stg_total_spent_workspace')}}
),
trial as(
  SELECT * from {{ref('stg_trial_workspaces')}}
),
user_count as(
    SELECT * from {{ref('stg_workspace_user_counts')}}
),
attr as (
  select * from {{ref('stg_user_first_attribution')}} 
)

select 
workspaces.*,
if(total_spent_workspace.total_amount_spent is null, 0, total_spent_workspace.total_amount_spent) as total_amount_spent,
attr.source,
attr.medium,
attr.campaign,
if(trial.workspace_id is null, false, true) as trial_taken,
if(user_count.max_workspace_users is null, 1, user_count.max_workspace_users) as max_workspace_users,
if(user_count.min_workspace_users is null, 1, user_count.min_workspace_users) as min_workspace_users,
from  workspaces
left join total_spent_workspace on workspaces.workspace_id= total_spent_workspace.workspace_id
left join attr on workspaces.user_id= attr.user_id
left join trial on workspaces.workspace_id= trial.workspace_id
left join user_count on workspaces.workspace_id= user_count.workspace_id
