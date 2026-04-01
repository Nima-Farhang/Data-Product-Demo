# Quick Start

This guide is for people who want to understand the repository quickly.

## 1. What this repository does

This repository demonstrates a full data product lifecycle inside one repo:

- provision Snowflake infrastructure
- build data models with dbt
- deploy Streamlit apps into Snowflake
- manage the process through CI/CD

## 2. High-level flow

```text
Terraform -> Snowflake resources
dbt       -> data models and marts
Streamlit -> user-facing apps
CI/CD     -> repeatable deployment
```

## 3. Key folders

- `.devcontainer/`  
  Developer environment and bootstrap script

- `TERRAFORM/`  
  Snowflake infrastructure code and environment-specific tfvars

- `DBT/data_product_demo/`  
  dbt project with seeds, staging models, marts, and tests

- `STREAMLIT/`  
  One folder per app, plus deployment script

## 4. Typical local workflow

### Infrastructure

Go to `TERRAFORM/` and follow:

- `README.md`
- `commands.md`

### dbt

Go to `DBT/data_product_demo/` and run:

```bash
dbt debug
dbt seed
dbt run
dbt test
```

### Streamlit

Go to `STREAMLIT/` and review:

- `README.md`
- `deploy_streamlit_apps.sh`

## 5. What to change if you reuse this project

### To create a new data product from this blueprint

Change these areas first:

- **Terraform**
  - database / warehouse sizing
  - schemas if needed
  - environment tfvars

- **dbt**
  - seed data
  - staging models
  - marts
  - tests

- **Streamlit**
  - app folders
  - `app.py`
  - `snowflake.yml`

- **CI/CD**
  - secrets
  - environment names
  - approval settings

## 6. Suggested reading by role

### Recruiter / hiring manager
Read:
- `README.md`
- `QUICKSTART.md`

### Engineer
Read:
- `TERRAFORM/README.md`
- `DBT/data_product_demo/README.md`
- `STREAMLIT/README.md`

### Reviewer who wants execution details
Read:
- `TERRAFORM/commands.md`
- `.github/workflows/`
