output "bucket_domain_name" {
  value = "https://${yandex_storage_bucket.netology-bucket.bucket_domain_name}/test_pic.jpg"
}