{{ config(materialized='view') }}

SELECT
    DATE(trip_start_time) AS trip_date,
    COUNT(*) AS total_trips,
    SUM(fare_amount) AS revenue

FROM {{ ref('trips') }}

GROUP BY trip_date
ORDER BY trip_date