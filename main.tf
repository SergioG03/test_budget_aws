# Configuración del provider y backend
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    encrypt        = true
    bucket         = "terraform-infrastructure-831926592006"
    dynamodb_table = "terraform-state-lock"
    key            = "terraform.tfstate"
    region         = "eu-west-3"
  }
}

provider "aws" {
  region = var.aws_region
}

# Data source para obtener el Account ID
data "aws_caller_identity" "current" {}

# S3 Bucket con nombre dinámico
resource "aws_s3_bucket" "data_bucket" {
  bucket = "bucket-data-${data.aws_caller_identity.current.account_id}"
  tags   = local.common_tags
}

# Recurso de presupuesto
resource "aws_budgets_budget" "monthly_budget" {
  name              = "budget_iac"
  budget_type       = "COST"
  limit_amount      = var.budget_limit
  limit_unit        = "USD"
  time_period_start = "2024-01-01_00:00"
  time_unit         = "MONTHLY"

  dynamic "notification" {
    for_each = var.budget_notifications
    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = notification.value
      threshold_type            = "PERCENTAGE"
      notification_type         = "ACTUAL"
      subscriber_email_addresses = [var.email_address]
    }
  }

  tags = local.common_tags
}

# Módulo IAM
module "iam" {
  source     = "./iam"
  user1_name = "sergio"
  user2_name = "terraform"
}
