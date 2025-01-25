variable "region" {
  default = "us-east-1"
}

variable "subnets" {
  description = "List of subnets"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
}
