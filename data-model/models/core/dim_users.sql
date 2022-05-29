with 
total_spent_user as (
  SELECT * from {{ref('stg_total_spent_user')}}
),
trial as(
  SELECT * from {{ref('stg_trial_users')}}
),
total_workspaces as (
  select * from {{ref('stg_total_workspaces_user')}}
),
user_count as(
    SELECT * from {{ref('stg_user_user_counts')}}
),
attr as (
  select * from {{ref('stg_user_first_attribution')}} 
)

select 
us.*,
if(total_spent_user.total_amount_spent is null, 0, total_spent_user.total_amount_spent) as total_amount_spent,
if(total_workspaces.owned_workspaces is null, 0, total_workspaces.owned_workspaces) as owned_workspaces,
attr.source,
attr.medium,
attr.campaign as campaign,
if(trial.number_of_trials_taken is null, 0, trial.number_of_trials_taken) as number_of_trials_taken,
if(user_count.max_workspace_users is null, 1, user_count.max_workspace_users) as max_workspace_users,
if(user_count.min_workspace_users is null, 1, user_count.min_workspace_users) as min_workspace_users,
from  {{ source('sources', 'users') }} us
left join total_workspaces on total_workspaces.user_id = us.user_id
left join total_spent_user on total_spent_user.user_id = us.user_id
left join attr on us.user_id= attr.user_id
left join trial on trial.user_id = us.user_id
left join user_count on user_count.user_id = us.user_id
