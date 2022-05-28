SELECT *,
date_trunc(started_on, MONTH) as charge_month
 FROM {{ source('sources', 'subscription_periods') }}