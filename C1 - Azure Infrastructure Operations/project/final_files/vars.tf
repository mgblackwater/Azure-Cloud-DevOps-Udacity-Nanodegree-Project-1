variable "prefix" {
  default = "udacity"
  description = "The prefix which should be used for all resources in this main"
}

variable "location" {
  default = "southeastasia"
  description = "The Azure Region in which all resources in this main should be created."
}

variable "admin_username" {
  default = ""
  description = "The username of the administrator."
}

variable "admin_password" {
  default = ""
  description = "Password of the administrator."
}

variable "vm_count" {
  default = 2
  description = "Number of VM to be created and attach to load balancer."
}