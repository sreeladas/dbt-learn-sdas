{{
  config(
    materialized='view'
  )
}}

with orders as (

    select * from {{ ref('stg_orders') }}

),

payment as (

    select * from {{ ref('stg_payment') }}
),

final as (
    select
        orders.order_id,
        coalesce(payment.order_amount, 0) as amount,
        orders.customer_id,
        orders.order_date,
        orders.status
    from orders
    left join payment using (order_id)
)

select * from final