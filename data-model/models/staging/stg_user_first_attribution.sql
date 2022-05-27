with atr as (
    SELECT user_id, 
    source, 
    medium,
    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY session_date) rn
    FROM {{ref('base_ga_sessions')}} 
    where user_id is not null
    order by user_id
)
select * from atr where rn=1