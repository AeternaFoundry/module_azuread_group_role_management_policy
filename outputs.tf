output "group_role_management_policies_id" {
  description = "Map of id values across all group_role_management_policies, keyed the same as var.group_role_management_policies"
  value       = { for k, v in azuread_group_role_management_policy.group_role_management_policies : k => v.id }
}
output "group_role_management_policies_activation_rules" {
  description = "Map of activation_rules values across all group_role_management_policies, keyed the same as var.group_role_management_policies"
  value       = { for k, v in azuread_group_role_management_policy.group_role_management_policies : k => one(v.activation_rules) }
}
output "group_role_management_policies_active_assignment_rules" {
  description = "Map of active_assignment_rules values across all group_role_management_policies, keyed the same as var.group_role_management_policies"
  value       = { for k, v in azuread_group_role_management_policy.group_role_management_policies : k => one(v.active_assignment_rules) }
}
output "group_role_management_policies_description" {
  description = "Map of description values across all group_role_management_policies, keyed the same as var.group_role_management_policies"
  value       = { for k, v in azuread_group_role_management_policy.group_role_management_policies : k => v.description }
}
output "group_role_management_policies_display_name" {
  description = "Map of display_name values across all group_role_management_policies, keyed the same as var.group_role_management_policies"
  value       = { for k, v in azuread_group_role_management_policy.group_role_management_policies : k => v.display_name }
}
output "group_role_management_policies_eligible_assignment_rules" {
  description = "Map of eligible_assignment_rules values across all group_role_management_policies, keyed the same as var.group_role_management_policies"
  value       = { for k, v in azuread_group_role_management_policy.group_role_management_policies : k => one(v.eligible_assignment_rules) }
}
output "group_role_management_policies_group_id" {
  description = "Map of group_id values across all group_role_management_policies, keyed the same as var.group_role_management_policies"
  value       = { for k, v in azuread_group_role_management_policy.group_role_management_policies : k => v.group_id }
}
output "group_role_management_policies_notification_rules" {
  description = "Map of notification_rules values across all group_role_management_policies, keyed the same as var.group_role_management_policies"
  value       = { for k, v in azuread_group_role_management_policy.group_role_management_policies : k => one(v.notification_rules) }
}
output "group_role_management_policies_role_id" {
  description = "Map of role_id values across all group_role_management_policies, keyed the same as var.group_role_management_policies"
  value       = { for k, v in azuread_group_role_management_policy.group_role_management_policies : k => v.role_id }
}

