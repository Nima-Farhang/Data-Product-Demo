variable "snowflake_organization_name" {
  description = "Snowflake organization name."
  type        = string
}

variable "snowflake_account_name" {
  description = "Snowflake account name."
  type        = string
}

variable "snowflake_username" {
  description = "Terraform user for Snowflake authentication."
  type        = string
  sensitive   = true
}

variable "snowflake_password" {
  description = "Terraform user password for Snowflake authentication."
  type        = string
  sensitive   = true
}

variable "snowflake_role" {
  description = "Snowflake role used by Terraform."
  type        = string
  default     = "ACCOUNTADMIN"
}

variable "environment" {
  description = "Environment name used in object names."
  type        = string
  default     = "demo"
}

variable "database_name" {
  description = "Primary database name for the demo data product."
  type        = string
  default     = "DEMO_DATA_PRODUCT"
}

variable "warehouse_name" {
  description = "Warehouse name for the demo data product."
  type        = string
  default     = "DEMO_DATA_PRODUCT_WH"
}

variable "warehouse_size" {
  description = "Snowflake warehouse size."
  type        = string
  default     = "XSMALL"
}

variable "warehouse_auto_suspend" {
  description = "Warehouse auto suspend time in seconds."
  type        = number
  default     = 60
}

variable "schemas" {
  description = "Schemas to create in the demo database."
  type        = list(string)
  default     = ["RAW", "ANALYTICS", "APP"]
}
