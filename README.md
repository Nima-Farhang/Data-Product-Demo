# Data Product Demo

A self-contained, end-to-end data product blueprint built with Snowflake, dbt, Streamlit, Terraform, and GitHub Actions.

This repository is designed to show how a **small, reusable data product** can be built and deployed from a **single repository**. The idea is similar to a microservice, but applied to data: one repo contains the infrastructure, data models, application layer, and CI/CD needed to stand up one focused data product.

## Why this project exists

Many companies do not need a large, heavily fragmented data platform to start getting value from data. They need something that is:

- understandable
- reproducible
- quick to deploy
- easy to own
- easy to extend

This project demonstrates that pattern.

It is intended as a **reference implementation** for a consultancy-style delivery model, where the same blueprint can be reused for multiple small or medium-sized data products with only limited changes to datasets, models, and app logic.

## What this demo includes

- **Terraform** to provision Snowflake resources
- **dbt** to build a layered analytics model
- **Snowflake Streamlit** to expose business-facing apps
- **GitHub Actions** for CI/CD across infrastructure, transformation, and app deployment
- **GitHub Codespaces** for a reproducible development environment

## Architecture at a glance

```text
GitHub Repository
│
├── TERRAFORM/
│   └── Creates Snowflake database, schemas, warehouse, and supporting objects
│
├── DBT/
│   └── Seeds, staging models, marts, and tests
│
├── STREAMLIT/
│   └── App folders, one folder per app, deployed into Snowflake
│
└── .github/workflows/
    └── CI/CD for Terraform, dbt, and Streamlit
```

## Snowflake layer design

This demo uses a simple layered approach:

- **RAW**: seed/input data
- **STAGING**: source-aligned cleanup and normalization
- **ANALYTICS**: dimensions, facts, and marts
- **APP**: Streamlit app deployment target

## Repository structure

```text
.devcontainer/                Codespaces setup and init script
.github/workflows/            CI/CD workflows

TERRAFORM/                    Snowflake infrastructure as code
DBT/data_product_demo/        dbt project
STREAMLIT/                    Streamlit deployment assets
```

## Current demo scope

This repository currently demonstrates:

- environment-aware Snowflake provisioning
- dbt seed, run, and test workflows
- multiple Streamlit apps deployed from subfolders
- a single-repo delivery model for a reusable data product pattern

This is a demo, but it is deliberately structured to resemble a real delivery pattern rather than a toy example.

## Recommended reading order

If you are visiting this repository for the first time, start here:

1. `QUICKSTART.md`
2. `TERRAFORM/README.md`
3. `DBT/data_product_demo/README.md`
4. `STREAMLIT/README.md`

## Notes

- This project is intentionally opinionated.
- It favors clarity and reproducibility over maximum flexibility.
- It is meant to be a strong starting point for small-scale data product delivery, not a finished enterprise platform.

## Future extensions

Likely next steps for this blueprint would be:

- stronger role/grant hardening
- app sharing automation
- ingestion expansion through AWS Glue and Iceberg
- richer CI/CD promotion controls
- more advanced dbt testing and observability
