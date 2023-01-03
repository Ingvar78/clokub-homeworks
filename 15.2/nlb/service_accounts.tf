resource "yandex_iam_service_account" "sa-netology" {
  name        = "netology-sa"
  description = "Service account to manage s3 bucket ${var.sa_s3_name}"
  folder_id   = var.yc_folder_id
}


resource "yandex_iam_service_account_static_access_key" "sa-netology" {
  service_account_id = yandex_iam_service_account.sa-netology.id
  description        = "Static access key for object storage"
}
