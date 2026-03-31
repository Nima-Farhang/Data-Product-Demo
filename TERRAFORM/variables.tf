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

variable "svc_dbt_data_product_password" {
  description = "DBT user password for Snowflake authentication."
  type        = string
  sensitive   = true
}

variable "snowflake_password" {
  description = "Terraform user password for Snowflake authentication."
  type        = string
  sensitive   = true
}

variable "resource_monitor_credit_quota" {
  type        = number
  description = "Credit quota for the Snowflake resource monitor."
  default     = 10
}

variable "environment" {
  description = "Environment name used in object names."
  type        = string
}


variable "schemas" {
  description = "Schemas to create in the demo database."
  type        = list(string)
  default     = ["RAW", "STAGING", "INTERMEDIATE", "ANALYTICS", "APP"]
}

variable "warehouse_size" {
  description = "Warehouse size for the demo data product warehouse."
  type        = string
  default     = "xsmall"
}

variable "warehouse_auto_suspend" {
  description = "Auto suspend time in seconds for the demo data product warehouse."
  type        = number
  default     = 60
}

variable "grant_account_roles" {
  description = "The roles that are granted to a user"
  type        = list(string)
  default     = ["SYSADMIN"]
}
