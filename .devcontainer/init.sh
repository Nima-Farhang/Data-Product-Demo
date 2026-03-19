
#!/usr/bin/env bash
set -e

echo "Running init script..."

# export env vars (persist them properly)
echo "export TF_VAR_snowflake_username=\"$SNOWFLAKE_TERRAFORM_USER\"" >> ~/.bashrc
echo "export TF_VAR_snowflake_password=\"$SNOWFLAKE_TERRAFORM_PASS\"" >> ~/.bashrc
echo "export TF_VAR_snowflake_organization_name=\"$SNOWFLAKE_ORGANIZATION_NAME\"" >> ~/.bashrc
echo "export TF_VAR_snowflake_account_name=\"$SNOWFLAKE_ACCOUNT_NAME\"" >> ~/.bashrc
echo "export TF_VAR_svc_dbt_data_product_password=\"$DBT_DATA_PRODUCT_PASS\"" >> ~/.bashrc



## creating .dbt file with the required content for dbt to work
mkdir -p ~/.dbt
cat <<EOL > ~/.dbt/profiles.yml
data_product_demo:
  outputs:
    dev:
      account: ${SNOWFLAKE_ACCOUNT}
      database: DEV_DATA_PRODUCT_DB
      password: ${DBT_DATA_PRODUCT_PASS}
      role: ACCOUNTADMIN
      schema: RAW
      threads: 1
      type: snowflake
      user: SVC_DEV_DBT_DATA_PRODUCT
      warehouse: DEV_DATA_PRODUCT_DB_WH
  target: dev
EOL

cat ~/.dbt/profiles.yml