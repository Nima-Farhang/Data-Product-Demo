#!/usr/bin/env bash
set -e

echo "Running init script..."

# Set environment variables for Terraform and DBT
echo "export TF_VAR_snowflake_username=\"$SNOWFLAKE_TERRAFORM_USER\"" >> ~/.bashrc
echo "export TF_VAR_snowflake_password=\"$SNOWFLAKE_TERRAFORM_PASS\"" >> ~/.bashrc
echo "export TF_VAR_snowflake_organization_name=\"$SNOWFLAKE_ORGANIZATION_NAME\"" >> ~/.bashrc
echo "export TF_VAR_snowflake_account_name=\"$SNOWFLAKE_ACCOUNT_NAME\"" >> ~/.bashrc
echo "export TF_VAR_svc_dbt_data_product_password=\"$DBT_DATA_PRODUCT_PASS\"" >> ~/.bashrc

#  Set up DBT profiles.yml
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

# Set up Snowflake CLI config
mkdir -p ~/.snowflake/logs
cat <<EOL > ~/.snowflake/config.toml
[cli.logs]
save_logs = true
path = "/home/vscode/.snowflake/logs"
level = "info"

[connections.default]
account = "${SNOWFLAKE_ACCOUNT}"
user = "SVC_DEV_DBT_DATA_PRODUCT"
password = "${DBT_DATA_PRODUCT_PASS}"
role = "ACCOUNTADMIN"
warehouse = "DEV_DATA_PRODUCT_DB_WH"
database = "DEV_DATA_PRODUCT_DB"
schema = "RAW"
EOL

cat ~/.snowflake/config.toml
chmod 0600 ~/.snowflake/config.toml

# Set up AWS CLI credentials
AWS_CREDENTIALS_FILE="${HOME}/.aws/credentials"
mkdir -p "$(dirname "$AWS_CREDENTIALS_FILE")"

cat > "$AWS_CREDENTIALS_FILE" <<EOF
[default]
aws_access_key_id=${AWS_ACCESS_KEY_ID}
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}
EOF

echo "AWS CLI credentials for account '${SANDPIT_ACCOUNT_ID}' configured at ${AWS_CREDENTIALS_FILE}."
cat $AWS_CREDENTIALS_FILE


AWS_CONFIG_FILE="${HOME}/.aws/config"
mkdir -p "$(dirname "$AWS_CONFIG_FILE")"

cat > "$AWS_CONFIG_FILE" <<EOF
[default]
region = ap-southeast-2
output = json
EOF

echo "AWS CLI configuration configured at ${AWS_CONFIG_FILE}."

cat $AWS_CONFIG_FILE