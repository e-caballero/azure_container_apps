locals {
  common_tags = merge(local.standard_tags, var.additional_tags)

  standard_tags = {
    "Project"                       = var.project
    "Description"                   = var.description
    "Environment"                   = var.environment
    "External"                      = var.external
    "CostCenter"                    = var.cost_center
    "Compliance"                    = var.compliance
    "ApplicationID"                 = var.application_id
    "ApplicationOwner"              = var.application_owner
    "ApplicationOwnerEmail"         = var.application_owner_email
    "ApplicationTeam"               = var.application_team
    "ApplicationTeamEmail"          = var.application_team_email
    "ApplicationTeamSlack"          = var.application_team_slack
    "ApplicationTeamMicrosoftTeams" = var.application_teams_channel
  }

  # Resource naming convention
  resource_group_name = lower("${var.application_id}-${var.environment}-rg-${var.count_number}")
    container_app_name  = lower("${var.application_id}-${var.environment}-container-app-${var.count_number}")
    log_analytics_workspace_name = lower("${var.application_id}-${var.environment}-law-${var.count_number}")
    naming_convention = lower("${var.application_id}-${var.environment}-${var.count_number}")
}
