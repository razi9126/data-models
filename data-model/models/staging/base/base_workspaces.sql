SELECT 
owner_user_id as user_id,
workspace_id,
country_id,
created_at
 FROM {{ source('sources', 'workspaces') }}