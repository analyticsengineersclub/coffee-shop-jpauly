{{ config(
    materialized='table'
) }}

with customer_orders as (
    select
        customer_id, 
        min(created_at) as first_order_at,
        count(distinct id) as number_orders,
        max(created_at) as last_order_at
    from {{ ref('stg_coffee_shop__orders') }} as orders
    group by 1
)

select
    customers.id as customer_id,
    customers.name,
    customers.email,
    customer_orders.first_order_at,
    customer_orders.number_orders,
    customer_orders.last_order_at
from customer_orders
left join {{ ref('stg_coffee_shop__orders') }} as customers
  on customers.id = customer_orders.customer_id 
order by first_order_at asc