#https://cloud.yandex.ru/docs/kms/tutorials/terraform-key
resource "yandex_kms_symmetric_key" "key-a" {
  name              = "test-key"
  description       = "description for key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}

// Управление доступом к ключу, роль kms.keys.encrypterDecrypter, даёт права шифровать и расшифровывать данные ключами из определенного каталога:
resource "yandex_resourcemanager_folder_iam_member" "kms-user" {
  folder_id = var.yc_folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [yandex_iam_service_account.sa-bucket]
}