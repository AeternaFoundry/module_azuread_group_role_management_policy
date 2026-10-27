variable "group_role_management_policies" {
  description = <<EOT
Map of group_role_management_policies, attributes below
Required:
    - group_id
    - role_id
Optional:
    - activation_rules (block):
        - approval_stage (optional, block):
            - primary_approver (required, block):
                - object_id (required)
                - type (optional)
        - maximum_duration (optional)
        - require_approval (optional)
        - require_justification (optional)
        - require_multifactor_authentication (optional)
        - require_ticket_info (optional)
        - required_conditional_access_authentication_context (optional)
    - active_assignment_rules (block):
        - expiration_required (optional)
        - expire_after (optional)
        - require_justification (optional)
        - require_multifactor_authentication (optional)
        - require_ticket_info (optional)
    - eligible_assignment_rules (block):
        - expiration_required (optional)
        - expire_after (optional)
    - notification_rules (block):
        - active_assignments (optional, block):
            - admin_notifications (optional, block):
                - additional_recipients (optional)
                - default_recipients (required)
                - notification_level (required)
            - approver_notifications (optional, block):
                - additional_recipients (optional)
                - default_recipients (required)
                - notification_level (required)
            - assignee_notifications (optional, block):
                - additional_recipients (optional)
                - default_recipients (required)
                - notification_level (required)
        - eligible_activations (optional, block):
            - admin_notifications (optional, block):
                - additional_recipients (optional)
                - default_recipients (required)
                - notification_level (required)
            - approver_notifications (optional, block):
                - additional_recipients (optional)
                - default_recipients (required)
                - notification_level (required)
            - assignee_notifications (optional, block):
                - additional_recipients (optional)
                - default_recipients (required)
                - notification_level (required)
        - eligible_assignments (optional, block):
            - admin_notifications (optional, block):
                - additional_recipients (optional)
                - default_recipients (required)
                - notification_level (required)
            - approver_notifications (optional, block):
                - additional_recipients (optional)
                - default_recipients (required)
                - notification_level (required)
            - assignee_notifications (optional, block):
                - additional_recipients (optional)
                - default_recipients (required)
                - notification_level (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - read (optional)
        - update (optional)
EOT

  type = map(object({
    group_id = string
    role_id  = string
    activation_rules = optional(object({
      approval_stage = optional(object({
        primary_approver = list(object({
          object_id = string
          type      = optional(string)
        }))
      }))
      maximum_duration                                   = optional(string)
      require_approval                                   = optional(bool)
      require_justification                              = optional(bool)
      require_multifactor_authentication                 = optional(bool)
      require_ticket_info                                = optional(bool)
      required_conditional_access_authentication_context = optional(string)
    }))
    active_assignment_rules = optional(object({
      expiration_required                = optional(bool)
      expire_after                       = optional(string)
      require_justification              = optional(bool)
      require_multifactor_authentication = optional(bool)
      require_ticket_info                = optional(bool)
    }))
    eligible_assignment_rules = optional(object({
      expiration_required = optional(bool)
      expire_after        = optional(string)
    }))
    notification_rules = optional(object({
      active_assignments = optional(object({
        admin_notifications = optional(object({
          additional_recipients = optional(set(string))
          default_recipients    = bool
          notification_level    = string
        }))
        approver_notifications = optional(object({
          additional_recipients = optional(set(string))
          default_recipients    = bool
          notification_level    = string
        }))
        assignee_notifications = optional(object({
          additional_recipients = optional(set(string))
          default_recipients    = bool
          notification_level    = string
        }))
      }))
      eligible_activations = optional(object({
        admin_notifications = optional(object({
          additional_recipients = optional(set(string))
          default_recipients    = bool
          notification_level    = string
        }))
        approver_notifications = optional(object({
          additional_recipients = optional(set(string))
          default_recipients    = bool
          notification_level    = string
        }))
        assignee_notifications = optional(object({
          additional_recipients = optional(set(string))
          default_recipients    = bool
          notification_level    = string
        }))
      }))
      eligible_assignments = optional(object({
        admin_notifications = optional(object({
          additional_recipients = optional(set(string))
          default_recipients    = bool
          notification_level    = string
        }))
        approver_notifications = optional(object({
          additional_recipients = optional(set(string))
          default_recipients    = bool
          notification_level    = string
        }))
        assignee_notifications = optional(object({
          additional_recipients = optional(set(string))
          default_recipients    = bool
          notification_level    = string
        }))
      }))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.group_role_management_policies : (
        v.activation_rules == null || (v.activation_rules.approval_stage == null || (length(v.activation_rules.approval_stage.primary_approver) >= 1))
      )
    ])
    error_message = "Each primary_approver list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.group_role_management_policies : (
        can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", v.group_id))
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.group_role_management_policies : (
        v.eligible_assignment_rules == null || (v.eligible_assignment_rules.expire_after == null || (contains(["P15D", "P30D", "P90D", "P180D", "P365D"], v.eligible_assignment_rules.expire_after)))
      )
    ])
    error_message = "must be one of: \"P15D\", \"P30D\", \"P90D\", \"P180D\", \"P365D\""
  }
  validation {
    condition = alltrue([
      for k, v in var.group_role_management_policies : (
        v.active_assignment_rules == null || (v.active_assignment_rules.expire_after == null || (contains(["P15D", "P30D", "P90D", "P180D", "P365D"], v.active_assignment_rules.expire_after)))
      )
    ])
    error_message = "must be one of: \"P15D\", \"P30D\", \"P90D\", \"P180D\", \"P365D\""
  }
  validation {
    condition = alltrue([
      for k, v in var.group_role_management_policies : (
        v.activation_rules == null || (v.activation_rules.maximum_duration == null || (contains(["PT30M", "PT1H", "PT1H30M", "PT2H", "PT2H30M", "PT3H", "PT3H30M", "PT4H", "PT4H30M", "PT5H", "PT5H30M", "PT6H", "PT6H30M", "PT7H", "PT7H30M", "PT8H", "PT8H30M", "PT9H", "PT9H30M", "PT10H", "PT10H30M", "PT11H", "PT11H30M", "PT12H", "PT12H30M", "PT13H", "PT13H30M", "PT14H", "PT14H30M", "PT15H", "PT15H30M", "PT16H", "PT16H30M", "PT17H", "PT17H30M", "PT18H", "PT18H30M", "PT19H", "PT19H30M", "PT20H", "PT20H30M", "PT21H", "PT21H30M", "PT22H", "PT22H30M", "PT23H", "PT23H30M", "P1D"], v.activation_rules.maximum_duration)))
      )
    ])
    error_message = "must be one of: \"PT30M\", \"PT1H\", \"PT1H30M\", \"PT2H\", \"PT2H30M\", \"PT3H\", \"PT3H30M\", \"PT4H\", \"PT4H30M\", \"PT5H\", \"PT5H30M\", \"PT6H\", \"PT6H30M\", \"PT7H\", \"PT7H30M\", \"PT8H\", \"PT8H30M\", \"PT9H\", \"PT9H30M\", \"PT10H\", \"PT10H30M\", \"PT11H\", \"PT11H30M\", \"PT12H\", \"PT12H30M\", \"PT13H\", \"PT13H30M\", \"PT14H\", \"PT14H30M\", \"PT15H\", \"PT15H30M\", \"PT16H\", \"PT16H30M\", \"PT17H\", \"PT17H30M\", \"PT18H\", \"PT18H30M\", \"PT19H\", \"PT19H30M\", \"PT20H\", \"PT20H30M\", \"PT21H\", \"PT21H30M\", \"PT22H\", \"PT22H30M\", \"PT23H\", \"PT23H30M\", \"P1D\""
  }
  validation {
    condition = alltrue([
      for k, v in var.group_role_management_policies : (
        v.activation_rules == null || (v.activation_rules.approval_stage == null || (alltrue([for item in v.activation_rules.approval_stage.primary_approver : (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", item.object_id)))])))
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.group_role_management_policies : (
        v.activation_rules == null || (v.activation_rules.approval_stage == null || (alltrue([for item in v.activation_rules.approval_stage.primary_approver : (item.type == null || (contains(["singleUser", "groupMembers"], item.type)))])))
      )
    ])
    error_message = "must be one of: \"singleUser\", \"groupMembers\""
  }
  validation {
    condition = alltrue([
      for k, v in var.group_role_management_policies : (
        v.activation_rules == null || (v.activation_rules.required_conditional_access_authentication_context == null || (length(v.activation_rules.required_conditional_access_authentication_context) > 0))
      )
    ])
    error_message = "must not be empty"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

