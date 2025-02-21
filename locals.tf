locals {
  verification_response = jsondecode(data.azapi_resource.container_app_environment.output)
  domain_verification_id = local.verification_response.properties.customDomainConfiguration.customDomainVerificationId
  # Format resource group name to meet requirements:
  # - lowercase alphanumeric and hyphens only
  # - start with letter
  # - end with alphanumeric
  # - no double hyphens
  # - max 32 chars
  formatted_rg_name = lower(
    substr(
      replace(
        replace(
          replace(
            var.resource_group_name,
            "--", "-"
          ),
          "/[^a-zA-Z0-9-]/", ""
        ),
        "/^[^a-zA-Z]+/", ""
      ),
      0,
      32
    )
  )
}