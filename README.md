# Uber Ride Analytics (Databricks + dbt)

## Overview
<img width="4194" height="2219" alt="image" src="https://github.com/user-attachments/assets/afe5192c-840d-4276-86a4-cb564b152c2e" />


End-to-end data engineering pipeline using Databricks and dbt to transform raw ride data into analytics-ready datasets and business KPIs. The workflow follows a Lakehouse Medallion Architecture and enables scalable processing, historical tracking, and KPI-driven analytics for ride operations.

## Highlights

- End-to-end pipeline from raw data to dashboard.
- Lakehouse architecture implementation.
- SCD Type 2 modeling using dbt snapshots.
- KPI generation using Jinja-based SQL.
- Incremental data processing for scalability.

## Architecture

**Flow**: Raw Data → Bronze → Silver → Gold → KPI Layer → Dashboard
<img width="1024" height="1536" alt="image" src="https://github.com/user-attachments/assets/745f2f8c-3c37-4852-9110-05f3725aced4" />


## Data Layers

### Bronze Layer

Raw ingestion layer storing source data without transformation.
<img width="1600" height="813" alt="WhatsApp Image 2026-05-02 at 7 03 29 PM" src="https://github.com/user-attachments/assets/b1c7262c-122a-487a-86d2-058c0ce955bc" />


**Tables**

- `bronze.trips`
- `bronze.customers`
- `bronze.drivers`
- `bronze.locations`
- `bronze.payments`
- `bronze.vehicles`

### Silver Layer

Cleaned and structured datasets using PySpark transformations.

**Transformations**

- Data cleaning and normalization.
- Null handling.
- Standardization.
- Incremental loading.

**Tables**

- `silver.trips`
- `silver.customers`
- `silver.drivers`
- `silver.locations`
- `silver.payments`
- `silver.vehicles`

### Gold Layer (dbt)

Curated analytical layer built using dbt models and snapshots.

**Dimension Tables (SCD Type 2)**

- `DimCustomers`
- `DimDrivers`
- `DimLocations`
- `DimPayments`
- `DimVehicles`

**Features**

- Historical tracking using `dbt_valid_from` and `dbt_valid_to`.
- Current state filtering using `9999-12-31`.
- Change detection using timestamp strategy.

**Fact Table**

- `FactTrips` (transaction-level data)

**Key Fields**

- `trip_id`
- `driver_id`
- `customer_id`
- `vehicle_id`
- `distance_km`
- `fare_amount`

### KPI Layer

KPI models built using dbt and Jinja for reusable and scalable analytics.

**Core KPIs**

- Total Trips
- Total Revenue
- Average Trip Value
- Revenue per KM
- Trips per Driver
- Payment Success Rate

**Dimensional KPIs**

- Revenue by city
- Driver performance metrics
- Vehicle usage distribution
- Payment method analysis
  <img width="852" height="779" alt="WhatsApp Image 2026-05-02 at 3 16 57 PM" src="https://github.com/user-attachments/assets/661cdab6-781e-4450-b5d1-aadde463e4df" />


## Dashboard

Analytics dashboards built using Databricks SQL to visualize:

- Revenue trends over time
- City-level performance
- Driver rankings
- Payment success rates
- Vehicle utilization

  <img width="1063" height="1102" alt="WhatsApp Image 2026-05-02 at 5 37 18 PM" src="https://github.com/user-attachments/assets/3683b900-5f8c-4dc0-8322-52916a8312da" />
<img width="1050" height="1063" alt="WhatsApp Image 2026-05-02 at 5 37 41 PM" src="https://github.com/user-attachments/assets/4bc5deb8-39e7-4933-aee2-8147084be16c" />


## Pipeline Flow

- Raw data ingested into Bronze layer.
- PySpark transformations generate Silver layer.
- dbt builds Gold models and snapshots.
- KPI views generated using Jinja.
- Dashboard built on top of KPI layer.


## How to Run

1. Load raw data into Bronze layer.
2. Run PySpark notebooks for Silver transformations.
3. Execute dbt models:
   ```bash
   dbt run
   ```
4. Execute snapshots:
   ```bash
   dbt snapshot
   ```
5. Query KPI models and build dashboards using Databricks SQL.

## Tech Stack

- Databricks
- Apache Spark
- PySpark
- dbt
- SQL
- Delta Lake

## Key Features

- Incremental data processing for large datasets.
- SCD Type 2 implementation for historical tracking.
- Modular dbt models for maintainability.
- Jinja-based dynamic SQL generation.
- Scalable Lakehouse architecture.

## Business Impact

- Identifies high-performing drivers and cities.
- Enables revenue and demand analysis.
- Improves operational efficiency.
- Supports data-driven decision making.
