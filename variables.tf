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
  }))
  validation {
    condition = alltrue([
      for k, v in var.group_role_management_policies : (
        v.activation_rules == null || (v.activation_rules.approval_stage == null || (length(v.activation_rules.approval_stage.primary_approver) >= 1))
      )
    ])
    error_message = "Each primary_approver list must contain at least 1 items"
  }
}

