// Создание сервисного аккаунта
resource "yandex_iam_service_account" "sa-bucket" {
    name      = "sa-for-bucket"
}

// Выдаём права
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
    folder_id = var.yc_folder_id
    role      = "editor"
    member    = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
    depends_on = [yandex_iam_service_account.sa-bucket]
}

// Создаём статические ключи доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
    service_account_id = yandex_iam_service_account.sa-bucket.id
    description        = "static access key for bucket"
}

