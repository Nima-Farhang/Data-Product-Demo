output "database_name" {
  description = "Created Snowflake database name."
  value       = snowflake_database.data_product.name
}

output "warehouse_name" {
  description = "Created Snowflake warehouse name."
  value       = snowflake_warehouse.data_product.name
}

output "schema_names" {
  description = "Created Snowflake schema names."
  value       = sort([for schema in snowflake_schema.schemas : schema.name])
}

output "svc_dbt_data_product_login_name" {
  description = "Snowflake login name for the dbt service user."
  value       = snowflake_user.svc_dbt_data_product.login_name
  sensitive   = true
}
