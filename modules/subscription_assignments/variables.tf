variable "assignments" {
  description = "Map of subscription IDs to management group IDs."
  type = map(object({
    subscription_id     = string
    management_group_id = string
    display_name        = string
  }))

  default = {}
}
