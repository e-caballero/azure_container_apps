# Azure Container Apps Terraform Module

This Terraform module deploys an Azure Container App with custom domain support and optional Azure Front Door integration.

## Features

- Azure Container App deployment
- Custom domain configuration
- Log Analytics workspace integration
- Container App Environment setup
- DNS records management (CNAME and TXT records)
- Support for private container registries
- Environment variables management
- Tagging system

## Usage

```hcl
module "container_app" {
  source = "github.com/your-username/terraform-azure-container-apps"

  # Required variables
  environment        = "dev"
  registry_server    = "ghcr.io"
  ghcr_image        = "your-org/your-image:latest"
  registry_username = "your-username"
  registry_password = "your-pat-token"

  # Optional variables with defaults
  location                = "eastus"
  container_cpu          = 1.5
  container_memory       = "3Gi"
  container_listening_port = 3000
  dns_zone_name          = "example.com"
  dns_zone_rg            = "dns-rg"
  dns_website_name       = "myapp"
  front_door_enable      = false

  # Environment variables for the container
  container_env_vars = {
    "NODE_ENV" = "production"
    "API_URL"  = "https://api.example.com"
  }

  # Additional tags
  additional_tags = {
    "DeployedBy" = "Terraform"
  }
}
```

## Requirements

- Terraform >= 1.0
- AzureRM provider >= 3.0
- Azure subscription
- Azure DNS Zone (if using custom domain)
- Container registry with Docker image

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.0 |
| azapi | >= 1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Deployment environment (e.g., dev, staging, production) | string | n/a | yes |
| registry_server | The container registry server name | string | n/a | yes |
| ghcr_image | The Docker image from container registry, including tag | string | n/a | yes |
| registry_username | Username for container registry access | string | n/a | yes |
| registry_password | Password/token for container registry access | string | n/a | yes |
| location | Azure location for all resources | string | "eastus" | no |
| container_cpu | CPU cores for the container | number | 1.5 | no |
| container_memory | Memory allocation for the container | string | "3Gi" | no |
| container_listening_port | Container port to expose | number | 3000 | no |
| dns_zone_name | DNS zone name for custom domain | string | null | no |
| dns_zone_rg | Resource group of DNS zone | string | null | no |
| dns_website_name | Subdomain for the application | string | null | no |
| front_door_enable | Enable Azure Front Door integration | bool | false | no |
| container_env_vars | Environment variables for the container | map(string) | {} | no |
| additional_tags | Additional resource tags | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| application_url | The URL of the Container App |
| custom_domain_url | The custom domain URL of the application |
| container_app_name | Name of the Container App |
| container_app_revision | Current revision of the Container App |
| container_app_environment | Name of the Container App Environment |
| resource_group_name | Name of the resource group |
| location | Azure region where resources are deployed |
| important_urls | Map of important URLs for the application |

## Notes

- The module creates a new resource group for the Container App
- Custom domain configuration requires an existing Azure DNS Zone
- Container registry credentials are stored as secrets in the Container App
- Environment variables are stored as secrets in the Container App

## License

MIT 