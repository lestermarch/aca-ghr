terraform {
  # https://github.com/hashicorp/terraform/tags
  required_version = "~> 1.0"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_container_app_environment" "runners" {
  name                = local.resource_name.container_app_environment
  location            = var.location
  resource_group_name = var.resource_group_name

  infrastructure_subnet_id       = var.subnet_id
  internal_load_balancer_enabled = true
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  zone_redundancy_enabled        = var.enable_zone_redundancy

  workload_profile {
    name                  =

    maximum_count         = var.node_pool.maximum_nodes
    minimum_count         = var.node_pool.minimum_nodes
    workload_profile_type = local.node_pool_sku
  }

  tags = var.resource_tags
}
