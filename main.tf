data "tfe_organization" "this" {
  name = var.organization
}
## Use specific project if defined else place into the Default Project
data "tfe_project" "this" {
 name = (var.project_name != "" ? var.project_name : "Default Project" )
}
## Workspace configuration
resource "tfe_workspace" "this" {
  name = "${var.workspace_name}-${var.workspace_env}"
  description = var.workspace_description
  project_id = data.tfe_project.this.id
  terraform_version = var.tf_version
  assessments_enabled = var.workspace_assessments
  auto_apply = var.workspace_autoapply
}


// Notification to be sent to service now
// Eventually need to do a map here if prod is true, else to define diffences

resource "tfe_notification_configuration" "this" {
  name             = "${var.workspace_name}-${var.workspace_env}-notification"
  enabled          = true
  destination_type = "generic"
  triggers         = ["run:errored","run:needs_attention","assessment:failed", "assessment:check_failure", "assessment:drifted"]
  url              = var.notification_url
  workspace_id     = tfe_workspace.this.id
}