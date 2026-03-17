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
