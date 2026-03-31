#!/usr/bin/env bash
set -euo pipefail

echo "Running init script..."

BASHRC_FILE="${HOME}/.bashrc"
DBT_DIRECTORY="${HOME}/.dbt"
SNOWFLAKE_DIRECTORY="${HOME}/.snowflake"
AWS_DIRECTORY="${HOME}/.aws"
ENVIRONMENT_LOWER=$(echo "${ENVIRONMENT}" | tr '[:upper:]' '[:lower:]')

# Validate required input variables
required_variables=(
  ENVIRONMENT
  SNOWFLAKE_TERRAFORM_USER
  SNOWFLAKE_TERRAFORM_PASS
  SNOWFLAKE_ORGANIZATION_NAME
  SNOWFLAKE_ACCOUNT_NAME
  SNOWFLAKE_ACCOUNT
  DBT_DATA_PRODUCT_PASS
  AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY
  SANDPIT_ACCOUNT_ID
)

for variable_name in "${required_variables[@]}"; do
  if [[ -z "${!variable_name:-}" ]]; then
    echo "Error: required environment variable '${variable_name}' is not set."
    exit 1
  fi
done

# Set variables for the current shell process
export TF_VAR_snowflake_username="${SNOWFLAKE_TERRAFORM_USER}"
export TF_VAR_snowflake_password="${SNOWFLAKE_TERRAFORM_PASS}"
export TF_VAR_snowflake_organization_name="${SNOWFLAKE_ORGANIZATION_NAME}"
export TF_VAR_snowflake_account_name="${SNOWFLAKE_ACCOUNT_NAME}"
export TF_VAR_svc_dbt_data_product_password="${DBT_DATA_PRODUCT_PASS}"

# Safely replace or append export lines in ~/.bashrc
update_bashrc_export() {
  local variable_name="$1"
  local variable_value="$2"

  if grep -q "^export ${variable_name}=" "${BASHRC_FILE}"; then
    sed -i "s|^export ${variable_name}=.*$|export ${variable_name}='${variable_value}'|" "${BASHRC_FILE}"
  else
    echo "export ${variable_name}='${variable_value}'" >> "${BASHRC_FILE}"
  fi
}

update_bashrc_export "TF_VAR_snowflake_username" "${SNOWFLAKE_TERRAFORM_USER}"
update_bashrc_export "TF_VAR_snowflake_password" "${SNOWFLAKE_TERRAFORM_PASS}"
update_bashrc_export "TF_VAR_snowflake_organization_name" "${SNOWFLAKE_ORGANIZATION_NAME}"
update_bashrc_export "TF_VAR_snowflake_account_name" "${SNOWFLAKE_ACCOUNT_NAME}"
update_bashrc_export "TF_VAR_svc_dbt_data_product_password" "${DBT_DATA_PRODUCT_PASS}"

echo "Terraform environment variables updated in current shell and ${BASHRC_FILE}"

# Set up DBT profiles.yml
mkdir -p "${DBT_DIRECTORY}"

cat > "${DBT_DIRECTORY}/profiles.yml" <<EOF
data_product_demo:
  outputs:
    ${ENVIRONMENT_LOWER}:
      account: ${SNOWFLAKE_ACCOUNT}
      database: ${ENVIRONMENT}_DATA_PRODUCT_DB
      password: ${DBT_DATA_PRODUCT_PASS}
      role: ACCOUNTADMIN
      schema: RAW
      threads: 1
      type: snowflake
      user: SVC_${ENVIRONMENT}_DBT_DATA_PRODUCT
      warehouse: ${ENVIRONMENT}_DATA_PRODUCT_DB_WH
  target: ${ENVIRONMENT_LOWER}
EOF

echo "Created ${DBT_DIRECTORY}/profiles.yml"

# Set up Snowflake CLI config
mkdir -p "${SNOWFLAKE_DIRECTORY}/logs"

cat > "${SNOWFLAKE_DIRECTORY}/config.toml" <<EOF
[cli.logs]
save_logs = true
path = "${SNOWFLAKE_DIRECTORY}/logs"
level = "info"

[connections.default]
account = "${SNOWFLAKE_ACCOUNT}"
user = "SVC_${ENVIRONMENT}_DBT_DATA_PRODUCT"
password = "${DBT_DATA_PRODUCT_PASS}"
role = "ACCOUNTADMIN"
warehouse = "${ENVIRONMENT}_DATA_PRODUCT_DB_WH"
database = "${ENVIRONMENT}_DATA_PRODUCT_DB"
schema = "RAW"
EOF

chmod 0600 "${SNOWFLAKE_DIRECTORY}/config.toml"

echo "Created ${SNOWFLAKE_DIRECTORY}/config.toml"

# Set up AWS CLI credentials
mkdir -p "${AWS_DIRECTORY}"

cat > "${AWS_DIRECTORY}/credentials" <<EOF
[default]
aws_access_key_id=${AWS_ACCESS_KEY_ID}
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}
EOF

cat > "${AWS_DIRECTORY}/config" <<EOF
[default]
region = ap-southeast-2
output = json
EOF

chmod 0600 "${AWS_DIRECTORY}/credentials" "${AWS_DIRECTORY}/config"

echo "AWS CLI credentials for account '${SANDPIT_ACCOUNT_ID}' configured at ${AWS_DIRECTORY}/credentials"

echo "AWS CLI configuration configured at ${AWS_DIRECTORY}/config"

echo
echo "Init script completed."
echo "Note: if you ran this script normally, reload your shell with:"
echo "  source ~/.bashrc"
echo
echo "Check the Terraform password variable with:"
echo "  echo \"\$TF_VAR_svc_dbt_data_product_password\""