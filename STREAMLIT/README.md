# Streamlit

This folder contains the Streamlit app deployment assets for the demo data product.

## Structure

The repository uses **one folder per app** under `STREAMLIT/apps/`.

Example:

```text
STREAMLIT/
  apps/
    sales_overview/
      app.py
      snowflake.yml
      environment.yml

    service_ops/
      app.py
      snowflake.yml
      environment.yml
```

## Deployment model

The deployment process is designed to:

1. loop through app folders
2. enter each folder
3. replace the environment placeholder in `snowflake.yml`
4. run `snow streamlit deploy`

This logic is implemented in:

```text
deploy_streamlit_apps.sh
```

## Typical command

Run from the repository root:

```bash
bash STREAMLIT/deploy_streamlit_apps.sh
```

## What to change when adding a new app

To add a new app:

1. create a new folder under `STREAMLIT/apps/`
2. add:
   - `app.py`
   - `snowflake.yml`
   - `environment.yml`
3. make sure `snowflake.yml` follows the expected pattern

Example pattern:

```yaml
definition_version: 1
streamlit:
  name: SALES_OVERVIEW
  database: %ENVIRONMENT%_DATA_PRODUCT_DB
  schema: APP
  query_warehouse: %ENVIRONMENT%_DATA_PRODUCT_DB_WH
  main_file: app.py
  env_file: environment.yml
```

## Notes

Only `%ENVIRONMENT%` is parameterized in `snowflake.yml`.

This keeps the deployment logic simple and predictable.

## CI/CD

The GitHub Actions workflow for this layer is under:

```text
.github/workflows/streamlit.yml
```

That workflow is responsible for:

- preparing Snowflake CLI config
- validating connection
- deploying each app folder
