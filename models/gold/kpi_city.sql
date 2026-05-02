{{ config(materialized='view') }}

{% set metrics = [
    ('total_trips', 'COUNT(t.trip_id)'),
    ('total_revenue', 'SUM(t.fare_amount)'),
    ('avg_trip_value', 'AVG(t.fare_amount)'),
    ('revenue_per_km', 'SUM(t.fare_amount)/NULLIF(SUM(t.distance_km),0)'),
    ('trips_per_driver', 'COUNT(t.trip_id)/NULLIF(COUNT(DISTINCT t.driver_id),0)')
] %}

SELECT
    c.city,

{% for name, formula in metrics %}
    {{ formula }} AS {{ name }}{% if not loop.last %},{% endif %}
{% endfor %}

FROM {{ ref('trips') }} t

JOIN {{ ref('DimCustomers') }} c
    ON t.customer_id = c.customer_id
    AND c.dbt_valid_to = '9999-12-31'

GROUP BY c.city
ORDER BY total_revenue DESC