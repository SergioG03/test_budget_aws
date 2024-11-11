variable "aws_region" {
  type        = string
  description = "AWS Region for the resources"
  default     = "us-west-2"
}

variable "email_address" {
  type        = string
  description = "Email address for budget notifications"
}

variable "budget_limit" {
  type        = string
  description = "Monthly budget limit in USD"
  default     = "25"
}

variable "budget_notifications" {
  type        = set(number)
  description = "Set of notification thresholds for budget alerts"
  default     = [20, 40, 60, 80, 100]
}

locals {
  common_tags = {
    nombre = "Sergio Gonzalo"
    iac    = "terraform"
    env    = "Automatización y despliegue"
  }
}
