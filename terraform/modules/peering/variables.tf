variable "source_resource_group_name" {
  type = string
}

variable "source_vnet_name" {
  type = string
}

variable "remote_vnet_id" {
  type = string
}

variable "peering_name" {
  type = string
}

variable "allow_forwarded_traffic" {
  type    = bool
  default = false
}

variable "allow_gateway_transit" {
  type    = bool
  default = false
}

variable "use_remote_gateways" {
  type    = bool
  default = false
}
