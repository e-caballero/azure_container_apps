variable "location" {
  description = "Azure location for all resources"
  type        = string
    default     = "eastus"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, production)"
  type        = string
}

variable "registry_server" {
  description = "The Azure Container Registry server name"
  type        = string
}

variable "image_name" {
  description = "Docker image name including tag"
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

variable "application_id" {
  description = "Application ID"
  type        = string
  default     = "sos"
}

variable "application_owner" {
  description = "Application owner name"
  type        = string
  default     = "Philip Sessa"
}

variable "application_owner_email" {
  description = "Email address of the application owner"
  type        = string
    default     = "sessapm@gmail.com"
}

variable "application_team" {
  description = "Name of the application team"
  type        = string
  default     = "SOS ICN App Team"
}

variable "application_team_email" {
  description = "Email address of the application team"
  type        = string
    default     = "support@sailorstay.com"
}

variable "application_team_slack" {
  description = "Slack channel of the application team"
  type        = string
    default     = "myteam"
}

variable "application_teams_channel" {
  description = "Microsoft Teams channel for the application"
  type        = string
    default     = "myteam"
}

variable "NEXT_PUBLIC_TEMPLATE_CLIENT_ID" {
  description = "Client ID for the application template"
  type        = string
  default     = "123456"
}


variable "cost_center" {
  description = "Cost center for billing purposes"
  type        = string
    default     = "12345"
}

variable "compliance" {
  description = "Compliance level for the resources"
  type        = string
  default     = "none"
}

variable "count_number" {
  description = "An identifier for multiple deployments in the same environment"
  type        = number
  default     = 1
}

variable "external" {
  description = "Indicates whether the resource is for external use"
  type        = string
  default     = "false"
}

variable "description" {
  description = "Description of the project"
  type        = string
  default     = ""
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
