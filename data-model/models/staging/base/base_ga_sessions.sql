
SELECT user_id, 
date as session_date, 
session_id, 
campaign,
SPLIT(source_medium, '/')[OFFSET(0)] as source,
SPLIT(source_medium, '/')[OFFSET(1)] as medium,
requested_demo
FROM {{ source('sources', 'ga_sessions') }}
order by session_date