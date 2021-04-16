variable "client_id" {
  type = string
  default = "value"
  #default = "${env("CLIENT_ID")}"
}

variable "client_secret" {
  type = string
  default = "value"
}

variable "resource_group_name" {
  type = string
  default = "value"
}

variable "storage_account" {
  type = string
  default = "value"
}

variable "subscription_id" {
  type = string
  default = "value"
}

variable "tenant_id" {
  type = string
  default = "value"
}

variable "location" {
  type = string
  default = "value"
}

variable "vm_size" {
  type = string
  default = "value"
}

variable "ssh_username" {
  type = string
  default = "value"
}

variable "ssh_password" {
  type = string
  default = "value"
}