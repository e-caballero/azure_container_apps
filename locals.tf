locals {
  # Format names to meet requirements:
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

  formatted_container_app_name = lower(
    substr(
      replace(
        replace(
          replace(
            var.container_app_name,
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

  verification_response = jsondecode(data.azapi_resource.container_app_environment.output)
  domain_verification_id = local.verification_response.properties.customDomainConfiguration.customDomainVerificationId
}