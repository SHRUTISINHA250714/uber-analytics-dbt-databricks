{{ config(materialized='view') }}

SELECT
    p.payment_method,
    COUNT(*) AS total_transactions,
    SUM(p.amount) AS total_revenue,
    SUM(CASE 
            WHEN p.payment_status = 'Success' THEN 1 
            ELSE 0 
        END
    ) / NULLIF(COUNT(*), 0) AS success_rate

FROM {{ ref('DimPayments') }} p   

WHERE p.dbt_valid_to = '9999-12-31'  

GROUP BY p.payment_method
ORDER BY total_revenue DESC