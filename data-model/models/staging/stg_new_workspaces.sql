select workspace_id,charge_month
from {{ref('stg_previous_payments')}}
where difference_from_prev_payment is null
group by 1,2