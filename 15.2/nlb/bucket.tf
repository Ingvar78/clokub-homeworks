// Создаём Bucket
resource "yandex_storage_bucket" "netology-bucket" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = "netology-bucket"
    acl    = "public-read"
}

// Размещаем картинку в Bucket с правами на чтение всем.
resource "yandex_storage_object" "pictures" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = yandex_storage_bucket.netology-bucket.bucket
    key = "test_pic.png"
    source = "DevOps13.png"
    acl    = "public-read"
    depends_on = [yandex_storage_bucket.netology-bucket]
}