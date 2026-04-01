# dbt Project: data_product_demo

This folder contains the dbt project for the demo data product.

## Purpose

This layer takes input data from the `RAW` layer and transforms it into cleaner, business-facing models used by the Streamlit apps.

## Model structure

```text
models/
  staging/
    stg_*.sql

  marts/
    commercial/
    operations/
```

## Snowflake schema usage

This project is designed to map models into different Snowflake schemas:

- seeds -> `RAW`
- staging models -> `STAGING`
- marts -> `ANALYTICS`

## Typical commands

Run from this folder:

```bash
dbt debug
dbt seed
dbt run
dbt test
```

## What each command does

- `dbt debug`  
  Verifies connection and project/profile setup

- `dbt seed`  
  Loads CSV seed files into Snowflake

- `dbt run`  
  Builds the models

- `dbt test`  
  Executes the tests defined for the models

## Where to change things

### If you want to change the input demo data
Update files in:

```text
seeds/data_product_demo/
```

### If you want to change source cleanup logic
Update files in:

```text
models/staging/
```

### If you want to change business logic
Update files in:

```text
models/marts/
```

### If you want to change schema routing
Review:

- `dbt_project.yml`
- `macros/generate_schema_name.sql`

## Notes

This project intentionally keeps the structure simple and readable.

The goal is to show a clean, layered dbt pattern that can be reused in similar small data products.
