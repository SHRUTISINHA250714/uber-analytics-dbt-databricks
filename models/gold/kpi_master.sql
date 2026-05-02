{{ config(materialized='view') }}

{% set metrics = [
    ('total_trips', 'COUNT(t.trip_id)'),
    ('total_revenue', 'SUM(t.fare_amount)'),
    ('avg_trip_value', 'AVG(t.fare_amount)'),
    ('revenue_per_km', 'SUM(t.fare_amount)/NULLIF(SUM(t.distance_km),0)'),
    ('trips_per_driver', 'COUNT(t.trip_id)/NULLIF(COUNT(DISTINCT t.driver_id),0)')
] %}

SELECT

{% for name, formula in metrics %}
    {{ formula }} AS {{ name }}{% if not loop.last %},{% endif %}
{% endfor %},

COALESCE(
    SUM(CASE WHEN p.payment_status = 'Success' THEN 1 ELSE 0 END)
    /
    NULLIF(COUNT(DISTINCT t.trip_id),0),
0
) AS payment_success_rate

FROM {{ ref('trips') }} t

LEFT JOIN {{ ref('DimPayments') }} p
    ON t.trip_id = p.trip_id
    AND (p.dbt_valid_to = '9999-12-31' OR p.dbt_valid_to IS NULL)