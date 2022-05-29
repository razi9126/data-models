with atr as (
    SELECT user_id, 
    source, 
    medium,
    campaign,
    session_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY session_date) rn
    FROM {{ref('base_ga_sessions')}} 
    where user_id is not null
    order by session_date
)
select * from atr where rn=1