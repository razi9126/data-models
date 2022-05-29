select workspace_id,charge_month
from {{ref('stg_previous_payments')}}
where difference_from_prev_payment>1
group by 1,2