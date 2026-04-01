# Terraform

This folder contains the Terraform code used to provision the Snowflake infrastructure for the demo data product.

## What this layer is responsible for

This Terraform project is responsible for creating the core Snowflake objects needed by the rest of the repository, including:

- database
- schemas
- warehouse
- resource monitor
- service user inputs and supporting objects, where applicable

## Environment model

This project is structured to support separate environments.

Current environment files live in:

```text
environments/dev.tfvars
environments/prod.tfvars
```

Backend configuration is also split by environment.

## Main files

- `main.tf`  
  Core resource definitions

- `variables.tf`  
  Input variables

- `outputs.tf`  
  Outputs for validation and debugging

- `provider.tf` / `versions.tf`  
  Provider and Terraform version config

- `backend-dev.hcl` / `backend-prod.hcl`  
  Backend configuration

- `commands.md`  
  Practical commands to run this Terraform project

## How to work with this folder

Use `commands.md` for exact command examples.

Typical flow:

```bash
terraform init -reconfigure -backend-config=backend-dev.hcl
terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```

## What to change when reusing this blueprint

Common changes for a new project:

- warehouse size / suspend settings
- environment tfvars values
- naming conventions
- grants / role design
- resource monitor quota
- backend bucket and key naming

## Notes

This layer should be treated as the foundation for the dbt and Streamlit layers.

If infrastructure is wrong, the rest of the repository will fail for predictable reasons.
