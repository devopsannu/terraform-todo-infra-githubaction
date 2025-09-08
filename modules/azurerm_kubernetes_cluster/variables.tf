variable "aks_name" {}
variable "location" {}
variable "rg_name" {}
variable "dns_prefix" {}
variable "node_count" {
  default = 1
}
variable "vm_size" {
  #  default = "Standard_DS2_v2"
  default = "Standard_D2s_v3"
}
variable "tags" {}
