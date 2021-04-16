variable "client_id" {
  type = string
  #default = "${env("CLIENT_ID")}"
}

variable "client_secret" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "storage_account" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "ssh_username" {
  type = string
}

variable "ssh_password" {
  type = string
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    owner = "patrick"
    email = "pcarey"
    se-region = "australiaeast"
    purpose = "azure testing"
    ttl = "8"
    terraform = "true"
    hc-internet-facing = "false"
  }
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "azure-arm" "basic-example" {
  client_id = var.client_id
  client_secret = var.client_secret
#  resource_group_name = var.resource_group_name
#  storage_account = var.storage_account
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id

#  capture_container_name = "images"
#  capture_name_prefix = "packer"

  managed_image_resource_group_name = var.resource_group_name
  managed_image_name = "pcarey-centos-8-${local.timestamp}"

  ssh_username = var.ssh_username
  ssh_password = var.ssh_password

  os_type = "Linux"
  image_publisher = "OpenLogic"
  image_offer = "CentOS"
  image_sku = "8_3"
  image_version = "latest"
  ssh_pty = "true"

  azure_tags = local.common_tags

  location = var.location
  vm_size = var.vm_size
}

build {
  sources = ["sources.azure-arm.basic-example"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline = [
        "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ]

    inline_shebang = "/bin/sh -x"
    skip_clean = "true"


#  provisioner "file" {
#    destination = "/home/ubuntu/"
#    source      = "./welcome.txt"
#  }
#  provisioner "shell" {
#    inline = ["ls -al /home/ubuntu", "cat /home/ubuntu/welcome.txt"]
#  }
#  provisioner "shell" {
#    script = "./example.sh"
#  }

  }


}