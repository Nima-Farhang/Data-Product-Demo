resource "snowflake_database" "data_product" {
  name    = "${var.environment}_DATA_PRODUCT_DB"
  comment = "Demo data product database managed by Terraform."
}

resource "snowflake_warehouse" "data_product" {
  name                         = "${var.environment}_DATA_PRODUCT_DB_WH"
  warehouse_size               = "xsmall"
  auto_suspend                 = 60
  auto_resume                  = true
  initially_suspended          = true
  statement_timeout_in_seconds = 600
  comment                      = "Demo data product warehouse managed by Terraform."
}

locals {
  svc_dbt_data_product_login_name = "SVC_${upper(var.environment)}_DBT_DATA_PRODUCT"
}


resource "snowflake_schema" "schemas" {
  for_each = toset(var.schemas)

  database = snowflake_database.data_product.name
  name     = each.value
  comment  = "${each.value} schema for the demo data product."
}

resource "snowflake_user" "svc_dbt_data_product" {
  name         = local.svc_dbt_data_product_login_name
  login_name   = local.svc_dbt_data_product_login_name
  display_name = local.svc_dbt_data_product_login_name
  comment      = "Service user for the data product dbt workload."
  password     = var.svc_dbt_data_product_password
}

resource "snowflake_grant_account_role" "svc_dbt_data_product_grants" {
  for_each = toset(var.grant_account_role)

  role_name = each.value
  user_name = snowflake_user.svc_dbt_data_product.name

}

