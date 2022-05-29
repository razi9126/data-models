select 
user_id, count(distinct(workspace_id)) as owned_workspaces
from {{ref('base_workspaces')}} ws
group by 1