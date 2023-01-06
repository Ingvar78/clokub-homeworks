// Создание сервисного аккаунта
resource "yandex_iam_service_account" "sa-bucket" {
    name      = "sa-for-bucket"
}

// Выдаём права
#viewer — позволяет только просматривать информацию о ресурсах.
#editor — позволяет управлять ресурсами (создавать и изменять их).
#admin — позволяет управлять доступом к ресурсам и самими ресурсами (создавать, изменять и удалять их).
#yc iam role list - список всех ролей, выбрать подходящую

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

