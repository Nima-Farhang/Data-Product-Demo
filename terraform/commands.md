# Terraform commands

These commands assume you are inside the `Terraform` folder.

## 1. Export Codespaces secrets into Terraform variables

```bash
export TF_VAR_snowflake_username="$SNOWFLAKE_TERRAFORM_USER"
export TF_VAR_snowflake_password="$SNOWFLAKE_TERRAFORM_PASS"
```

## 3. Initialize Terraform

```bash
terraform init
```

## 4. Check formatting

```bash
terraform fmt -recursive
```

## 5. Validate configuration

```bash
terraform validate
```

## 6. Review the execution plan

```bash
terraform plan
```

## 7. Apply the infrastructure

```bash
terraform apply
```

## 8. Show outputs

```bash
terraform output
```

## 9. Destroy the demo infrastructure

```bash
terraform destroy
```
