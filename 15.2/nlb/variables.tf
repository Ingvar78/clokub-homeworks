variable yc_zone {
  type    = string
  default = "ru-central1-b"
  description = "Zone"
}
variable public_key_path {
  description = "~/.ssh/id_rsa.pub"
}
variable private_key_path {
  description = "~/.ssh/id_rsa"
}
variable yc_cloud_id {
  description = "cloud id"
}
variable yc_folder_id {
  description = "Folder"
}

variable "network" {
  type    = string
  default = "hw15-network"
}
variable "subnet" {
  type    = string
  default = "hw15-subnet"
}
variable "subnet_v4_cidr_blocks" {
  type    = list(string)
  default = ["172.31.0.0/16"]
}
variable "user" {
  type = string
  default = "yc-user"
}

variable "service_account_key_file" {
  description = "../YC/tf_sa_key.json"
}

variable "lamp_image" {
  default = "fd827b91d99psvq5fjit"
}