SELECT user_id,
    max(user_count) as max_workspace_users,
    min(user_count) as min_workspace_users,
    FROM {{ref('stg_workspace_monthly_charges')}}
    group by 1