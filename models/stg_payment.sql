{{
  config(
    materialized='view'
  )
}}

select
    id as order_id,
    coalesce(sum(amount), 0)/100 as order_amount
from raw.stripe.payment
where status = 'success'
group by 1