{{
  config(
    materialized='view'
  )
}}

with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('orders') }}

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        min(orders.order_date) as first_order_date,
        max(orders.order_date) as most_recent_order_date,
        coalesce(count(orders.order_id), 0) as number_of_orders,
        coalesce(sum(orders.amount), 0) as lifetime_amount

    from customers
    left join orders using (customer_id)

    group by 1,2,3

)

select * from final