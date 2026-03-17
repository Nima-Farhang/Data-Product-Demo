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

variable "environment" {
  description = "Environment name used in object names."
  type        = string
  default     = "dev"
}


variable "schemas" {
  description = "Schemas to create in the demo database."
  type        = list(string)
  default     = ["RAW", "ANALYTICS", "APP"]
}
