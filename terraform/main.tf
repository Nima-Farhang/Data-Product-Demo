resource "snowflake_database" "data_product" {
  name    = var.database_name
  comment = "Demo data product database managed by Terraform."
}

resource "snowflake_warehouse" "data_product" {
  name                      = var.warehouse_name
  warehouse_size            = var.warehouse_size
  auto_suspend              = var.warehouse_auto_suspend
  auto_resume               = true
  initially_suspended       = true
  statement_timeout_in_seconds = 600
  comment                   = "Demo data product warehouse managed by Terraform."
}

resource "snowflake_schema" "schemas" {
  for_each = toset(var.schemas)

  database = snowflake_database.data_product.name
  name     = each.value
  comment  = "${each.value} schema for the demo data product."
}
