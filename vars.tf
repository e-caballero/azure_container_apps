variable "location" {
  description = "Azure location for all resources"
  type        = string
    default     = "eastus"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, production)"
  type        = string
}

variable "container_cpu" {
  description = "CPU for the container"
  type        = number
  default    = 1.5
}

variable "container_memory" {
  description = "Memory allocation for the container"
  type        = string
    default     = "3Gi"
}

variable "container_listening_port" {
  description = "Listening port for the container"
  type        = number
    default     = 3000
}

variable "common_tags" {
  description = "Common tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "additional_tags" {
  description = "Additional tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "SoS"
}

variable "count_number" {
  description = "An identifier for multiple deployments in the same environment"
  type        = number
  default     = 1
}

variable "ghcr_image" {
  description = "The Docker image from GitHub Container Registry, including the tag"
  type        = string
}

variable "registry_username" {
  description = "GitHub username or service account for accessing GHCR"
  type        = string
}

variable "registry_password" {
  description = "GitHub Personal Access Token (PAT) for accessing GHCR"
  type        = string
  default = ""
}

variable "dns_zone_name" {
  description = "DNS zone name"
  type        = string
  default     = "icloudnetwork.net"
}

variable "dns_zone_rg" {
  description = "Resource group for the DNS zone"
  type        = string
  default     = "prd-net"
}

variable "dns_website_name" {
  description = "DNS name for the website"
  type        = string
  default     = "sailorstay"
}

variable "front_door_enable" {
  description = "Enable Azure Front Door"
  type        = bool
  default     = false
}

variable "container_env_vars" {
  description = "Environment variables for the container app"
  type = map(string)
  default = {}
}

variable "container_app_name" {
  description = "Container app name"
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "Log analytics workspace name"
  type        = string
}

variable "naming_convention" {
  description = "Naming convention for the resources"
  type        = string
}