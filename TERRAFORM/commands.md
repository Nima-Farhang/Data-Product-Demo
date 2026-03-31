# Terraform commands

## Export environment variables

```bash
export TF_VAR_snowflake_username="$SNOWFLAKE_TERRAFORM_USER"
export TF_VAR_snowflake_password="$SNOWFLAKE_TERRAFORM_PASS"
export TF_VAR_snowflake_organization_name="$SNOWFLAKE_ORGANIZATION_NAME"
export TF_VAR_snowflake_account_name="$SNOWFLAKE_ACCOUNT_NAME"
export TF_VAR_svc_dbt_data_product_password="$DBT_DATA_PRODUCT_PASS"
```

## DEV init / plan

```bash
cd TERRAFORM

terraform init -reconfigure -backend-config=backend-dev.hcl
terraform plan -var-file=environments/dev.tfvars
```

## PROD init / plan

```bash
cd TERRAFORM

terraform init -reconfigure -backend-config=backend-prod.hcl
terraform plan -var-file=environments/prod.tfvars
```

## PROD apply (manual validation run)

```bash
cd TERRAFORM

terraform init -reconfigure -backend-config=backend-prod.hcl
terraform apply -var-file=environments/prod.tfvars
```
