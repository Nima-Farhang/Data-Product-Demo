# Terraform - Snowflake foundation

This folder creates the initial Snowflake foundation for the demo data product:

- 1 database
- 1 warehouse
- 5 schemas (`RAW`, `STAGING`, `INTERMEDIATE`, `ANALYTICS`, `APP`)

Credentials are not stored in code. Terraform reads the Snowflake username and password from Codespaces secrets through environment variables.

## Environment model

Use the same Terraform code for both DEV and PROD.

Environment-specific values live in:

- `environments/dev.tfvars`
- `environments/prod.tfvars`

Remote state is separated by backend key:

- `dev/snowflake/terraform.tfstate`
- `prod/snowflake/terraform.tfstate`

## Approval model

Use manual approval before applying to PROD in GitHub Actions.
