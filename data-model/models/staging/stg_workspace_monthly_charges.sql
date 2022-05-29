select * 
from {{ref('inter_subscription_workspaces')}}
where user_id is not null