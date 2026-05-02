{{ config(materialized='view') }}

SELECT
    v.vehicle_type,
    COUNT(t.trip_id) AS total_trips,
    SUM(t.fare_amount) AS revenue

FROM {{ ref('trips') }} t
JOIN {{ ref('DimVehicles') }} v
    ON t.vehicle_id = v.vehicle_id

WHERE v.dbt_valid_to = '9999-12-31'

GROUP BY v.vehicle_type