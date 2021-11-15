select
    
    date_trunc(first_order_at, month) as month,
    count(*) as total_customers

from {{ ref('customers') }}

group by 1