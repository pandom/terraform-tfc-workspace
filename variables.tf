variable "organization" {
    description = "Name of Terraform Organization"
    default = ""
    type = string
}

variable "workspace_description" {
  description = "This is the workspace description"
  default = "<< This workspace is managed via Terraform >>"
  type = string
}

# variable "workspace_name" {
#     description = "Name of Workspace to be created"
#     default = ""
#     type = string
# }
variable "workspace_name" {
  default = 00000
  description = "Workspace name as an Application ID"
  type = number
  validation {
    # regex(...) fails if there is not 5 values
    condition     = can(regex("^\\d{5}$", var.workspace_name))
    error_message = "The Application ID used for workspace name must be 5 numbers"
  }
}
variable "workspace_env" {
  default = "dev"
  description = "Workspace Environment name"
  type = string
  validation {
    # Validation fails if it is not prod or dev
    condition     = contains(["prod","dev"],var.workspace_env)
    error_message = "The workspace environment used must be prod or dev"
  }
}
variable "workspace_autoapply" {
  description = "Enable autoapply on workspace"
  default = true
  type = bool
}

variable "workspace_assessments" {
  description = "Enable Health and Drift Detection"
  default = true
  type = bool
}
variable "tf_beta" {
  description = "Beta Support for Terraform"
  default = false
  type = bool
}
variable "tf_version" {
  description = "Version of Terraform for workspace"
  default = "latest"
  type = string
}
variable "project_name" {
  description = "AppID for Project Name"
  default = ""
  type = string
}

variable "notification_url" {
  description = "URL for Notifications to be sent to"
  default = ""
  type = string
}