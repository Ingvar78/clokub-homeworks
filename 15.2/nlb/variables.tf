variable "yc_cloud_id" {
  description = "Cloud"
}
variable "yc_folder_id" {
  description = "Folder"
}
variable "yc_zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}


variable "service_account_key_file" {
  description = "../YC/tf_sa_key.json"
}


variable "sa_id" {
  description = "SERVICE ACCOUNT ID"
}


variable "nat_gw_img" {
  default = "fd80mrhj8fl2oe87o4e1"
}


variable "pub_key_path" {
  description = "Path to the public key used for ssh access"
  default     = "~/.ssh/id_rsa.pub"
}

variable "priv_key_path" {
  description = "Path to Private Key File"
  default     = "~/.ssh/id_rsa"
}

variable "meta_file" {
  description = "Metadata file for ssh"
}


variable "centos-7-base" {
  default = "fd8jvcoeij6u9se84dt5"
}

variable "sa_s3_name"{
  description = "Service account to manage s3 bucket"
  default     = "netology-sa"
}