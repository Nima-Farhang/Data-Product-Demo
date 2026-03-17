# Terraform - Snowflake foundation

This folder creates the initial Snowflake foundation for the demo data product:

- 1 database
- 1 warehouse
- 3 schemas (`RAW`, `ANALYTICS`, `APP`)

Credentials are not stored in code. Terraform reads the Snowflake username and password from Codespaces secrets through environment variables.
