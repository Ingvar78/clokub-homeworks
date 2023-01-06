// Создаём Bucket
# https://cloud.yandex.ru/docs/storage/operations/buckets/encrypt
resource "yandex_storage_bucket" "netology-bucket" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = "ingvar78-netology-bucket"
    acl    = "public-read"
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                kms_master_key_id = yandex_kms_symmetric_key.key-a.id
                sse_algorithm     = "aws:kms"
            }
        }
    }
}

# https://cloud.yandex.ru/docs/storage/operations/hosting/setup
# https://cloud.yandex.ru/docs/storage/operations/buckets/edit-acl
# https://cloud.yandex.ru/docs/storage/operations/hosting/certificate
# https://cloud.yandex.ru/docs/certificate-manager/quickstart/


// Размещаем картинку в Bucket с правами на чтение всем.
resource "yandex_storage_object" "pictures" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = yandex_storage_bucket.netology-bucket.bucket
    key = "test_pic.jpg"
    source = "./img/maxresdefault.jpg"
    acl    = "public-read"
    depends_on = [yandex_storage_bucket.netology-bucket]
}