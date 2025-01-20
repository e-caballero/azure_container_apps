# Container App URLs
output "application_url" {
  description = "The URL of the Container App"
  value       = "https://${azurerm_container_app.container_app.latest_revision_fqdn}"
}

output "custom_domain_url" {
  description = "The custom domain URL of the application"
  value       = var.front_door_enable ? null : "https://${var.dns_website_name}.${var.dns_zone_name}"
}

# Container App Details
output "container_app_name" {
  description = "Name of the Container App"
  value       = azurerm_container_app.container_app.name
}

output "container_app_revision" {
  description = "Current revision of the Container App"
  value       = azurerm_container_app.container_app.latest_revision_name
}

output "container_app_environment" {
  description = "Name of the Container App Environment"
  value       = azurerm_container_app_environment.container_app_env.name
}

# Resource Details
output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.resource_group.name
}

output "location" {
  description = "Azure region where resources are deployed"
  value       = var.location
}

# Environment Variables
output "environment_variables" {
  description = "List of environment variable names configured in the container"
  value       = keys(var.container_env_vars)
  sensitive   = false
}

# Tags
output "tags" {
  description = "Tags applied to the resources"
  value       = var.common_tags
}

# Important URLs - Highlighted
output "important_urls" {
  description = "Important URLs for the application"
  value = {
    main_app_url     = "https://${azurerm_container_app.container_app.latest_revision_fqdn}"
    custom_domain    = var.front_door_enable ? null : "https://${var.dns_website_name}.${var.dns_zone_name}"
    management_portal = "https://portal.azure.com/#@/resource${azurerm_container_app.container_app.id}"
  }
}
