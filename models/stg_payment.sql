{{
  config(
    materialized='view'
  )
}}

select
    id as order_id,
    coalesce(sum(amount), 0)/100 as order_amount
from {{ source('stripe', 'payments') }}
where status = 'success'
group by 1