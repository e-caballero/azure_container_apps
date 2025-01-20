resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.common_tags
}

# Create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.naming_convention}law"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.common_tags
}

# Azure Container App Environment
resource "azurerm_container_app_environment" "container_app_env" {
  name                       = "${var.container_app_name}-env"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.resource_group.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  tags                       = var.common_tags
}

# Grab the container DNS verification ID
data "azapi_resource" "container_app_environment" {
  resource_id = azurerm_container_app_environment.container_app_env.id
  type        = "Microsoft.App/managedEnvironments@2022-11-01-preview"
  response_export_values = ["properties.customDomainConfiguration.customDomainVerificationId"]
}

locals {
  domain_verification_id = jsondecode(data.azapi_resource.container_app_environment.output.properties).customDomainConfiguration.customDomainVerificationId
}

# Grab the DNS Zone
data "azurerm_dns_zone" "container_zone" {
  name                = var.dns_zone_name
  resource_group_name = var.dns_zone_rg
}

#direct container url DNS record creation 
resource "azurerm_dns_cname_record" "container_app" {
  count               = var.front_door_enable ? 0 : 1
  name                = var.dns_website_name
  zone_name           = data.azurerm_dns_zone.container_zone.name
  resource_group_name = data.azurerm_dns_zone.container_zone.resource_group_name
  ttl                 = 300
  record              = "${replace(var.container_app_name,"-","")}.${azurerm_container_app_environment.container_app_env.default_domain}"
}

resource "azurerm_dns_txt_record" "verification" {
  count               = var.front_door_enable ? 0 : 1
  name                = "asuid.${var.dns_website_name}"
  zone_name           = data.azurerm_dns_zone.container_zone.name
  resource_group_name = data.azurerm_dns_zone.container_zone.resource_group_name
  ttl                 = 300

  record {
    value = local.domain_verification_id
  }
}

# Azure Container App
resource "azurerm_container_app" "container_app" {
  name                         = replace(var.container_app_name, "-", "")
  container_app_environment_id = azurerm_container_app_environment.container_app_env.id
  resource_group_name          = azurerm_resource_group.resource_group.name
  revision_mode                = "Single"
  tags                         = var.common_tags

  secret {
    name  = "registry-password"
    value = var.registry_password
  }

  dynamic "secret" {
    for_each = var.container_env_vars
    content {
      # Convert the name to lowercase and replace invalid characters
      name  = lower(replace(replace(secret.key, "_", "-"), "/[^a-zA-Z0-9-]/", ""))
      value = sensitive(secret.value)
    }
  }

  registry {
    server               = var.registry_server
    username            = var.registry_username
    password_secret_name = "registry-password"
  }

  template {
    container {
      name   = var.container_app_name
      image  = "${var.registry_server}/${var.ghcr_image}"
      cpu    = var.container_cpu
      memory = var.container_memory

      dynamic "env" {
        for_each = var.container_env_vars
        content {
          name        = env.key
          secret_name = lower(replace(replace(env.key, "_", "-"), "/[^a-zA-Z0-9-]/", ""))
          value       = sensitive(env.value)
        }
      }
    }
  }

  ingress {
    external_enabled = true
    target_port     = var.container_listening_port

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}

resource "azurerm_container_app_custom_domain" "custom_domain" {
  count            = var.front_door_enable ? 0 : 1
  name             = "${var.dns_website_name}.${var.dns_zone_name}"
  container_app_id = azurerm_container_app.container_app.id

  depends_on = [
    azurerm_dns_cname_record.container_app,
    azurerm_dns_txt_record.verification
  ]

  lifecycle {
    ignore_changes = [
      certificate_binding_type,
      container_app_environment_certificate_id
    ]
  }
}