SELECT 
    sales_id, 
    quantity, 
    unit_price, 
    discount_amount, 
    net_amount, 
    payment_method, 
    (quantity * unit_price - discount_amount) AS total_amount
FROM {{ ref('stg_sales') }}
