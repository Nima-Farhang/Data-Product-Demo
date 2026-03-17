resource "snowflake_database" "data_product" {
  name    = "${var.environment}_data_product_db"
  comment = "Demo data product database managed by Terraform."
}

resource "snowflake_warehouse" "data_product" {
  name                         = "${var.environment}_data_product_db_wh"
  warehouse_size               = "xsmall"
  auto_suspend                 = 60
  auto_resume                  = true
  initially_suspended          = true
  statement_timeout_in_seconds = 600
  comment                      = "Demo data product warehouse managed by Terraform."
}

resource "snowflake_schema" "schemas" {
  for_each = toset(var.schemas)

  database = snowflake_database.data_product.name
  name     = each.value
  comment  = "${each.value} schema for the demo data product."
}
