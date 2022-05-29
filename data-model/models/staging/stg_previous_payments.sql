with lag_payments as
(SELECT
    charge_month,
    lag(charge_month) over(
      PARTITION by workspace_id
      ORDER BY
        charge_month
    ) AS prev_payment,
    workspace_id
  FROM
    {{ref('stg_workspace_monthly_charges')}} 
  order by workspace_id,charge_month
)
select lag_payments.*, date_diff(lag_payments.charge_month, lag_payments.prev_payment, MONTH) as difference_from_prev_payment
from lag_payments
