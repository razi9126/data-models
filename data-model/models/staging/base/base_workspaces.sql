SELECT 
owner_user_id as user_id,
workspace_id,
if(country_id is null, null, country_id) as country_id,
if(created_at is null, null, created_at) as created_at,
 FROM (
        SELECT  *, ROW_NUMBER() OVER (PARTITION BY workspace_id ORDER BY owner_user_id,created_at) rn
        FROM   {{ source('sources', 'workspaces') }}
        ) 
WHERE   rn = 1
ORDER BY
        workspace_id
