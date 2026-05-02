{{ config(materialized='view') }}

SELECT
    d.driver_id,
    d.full_name,
    COUNT(t.trip_id) AS total_trips,
    SUM(t.fare_amount) AS total_revenue,
    AVG(d.driver_rating) AS avg_rating

FROM {{ ref('trips') }} t
JOIN {{ ref('DimDrivers') }} d
    ON t.driver_id = d.driver_id

WHERE d.dbt_valid_to = '9999-12-31'

GROUP BY d.driver_id, d.full_name