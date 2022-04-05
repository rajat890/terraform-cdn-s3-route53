# Input Variables files
# enter the bucket name
variable "s3_bucket_name" {
  description = "name of s3 bucket"
  type        = string
  #default     = "terraform-default-bucket"
}

#tags to be passed
variable "s3_Owner" {
  description = "owner of s3"
  type        = string
  #default     = "terraform-owner"
}

variable "s3_environment" {
  description = "environment of s3"
  type        = string
  #default     = "terraform-env"
}

variable "s3_billing_code" {
  description = "billingcode of s3"
  type        = string
  #default     = "terraform-billingcode"
}

variable "s3_creator" {
  description = "creator of s3"
  type        = string
  #default     = "terraform-creator"
  #default = ["webapp-a", "webapp-b", "webapp-c"]
}

#variable "origin_id" {
#  description = "origing id  of CDN"
#  type        = string
#  #default  = "test-terraform"
#}

variable "fix_domain" {
  description = "testing of domaine"
  type        = string
  default     = "apps-hdfclife.com"
}
