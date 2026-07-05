select
    count(distinct sales_id) as total_orders,
    sum(quantity) as total_units_sold,
    sum(total_amount) as total_revenue,
    avg(total_amount) as average_order_value
from {{ ref('int_sales') }} 