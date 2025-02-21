locals {
  # Format names to meet requirements:
  # - lowercase alphanumeric and hyphens only
  # - start with letter
  # - end with alphanumeric
  # - no double hyphens
  # - max 32 chars
  formatted_name = (
    function(name) {
      lower(
        substr(
          replace(
            replace(
              replace(
                name,
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
  )

  formatted_rg_name = local.formatted_name(var.resource_group_name)
  formatted_container_app_name = local.formatted_name(var.container_app_name)
  verification_response = jsondecode(data.azapi_resource.container_app_environment.output)
  domain_verification_id = local.verification_response.properties.customDomainConfiguration.customDomainVerificationId
}