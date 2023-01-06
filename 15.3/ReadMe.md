```
iva@c9v:~/Documents/15.3 $ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_iam_service_account.sa-bucket will be created
  + resource "yandex_iam_service_account" "sa-bucket" {
      + created_at = (known after apply)
      + folder_id  = (known after apply)
      + id         = (known after apply)
      + name       = "sa-for-bucket"
    }

  # yandex_iam_service_account_static_access_key.sa-static-key will be created
  + resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
      + access_key           = (known after apply)
      + created_at           = (known after apply)
      + description          = "static access key for bucket"
      + encrypted_secret_key = (known after apply)
      + id                   = (known after apply)
      + key_fingerprint      = (known after apply)
      + secret_key           = (sensitive value)
      + service_account_id   = (known after apply)
    }

  # yandex_kms_symmetric_key.key-a will be created
  + resource "yandex_kms_symmetric_key" "key-a" {
      + created_at        = (known after apply)
      + default_algorithm = "AES_128"
      + description       = "description for key"
      + folder_id         = (known after apply)
      + id                = (known after apply)
      + name              = "test-key"
      + rotated_at        = (known after apply)
      + rotation_period   = "8760h"
      + status            = (known after apply)
    }

  # yandex_resourcemanager_folder_iam_member.kms-user will be created
  + resource "yandex_resourcemanager_folder_iam_member" "kms-user" {
      + folder_id = "b1gm6im3mcuc36r6kn8s"
      + id        = (known after apply)
      + member    = (known after apply)
      + role      = "kms.keys.encrypterDecrypter"
    }

  # yandex_resourcemanager_folder_iam_member.sa-editor will be created
  + resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
      + folder_id = "b1gm6im3mcuc36r6kn8s"
      + id        = (known after apply)
      + member    = (known after apply)
      + role      = "editor"
    }

  # yandex_storage_bucket.netology-bucket will be created
  + resource "yandex_storage_bucket" "netology-bucket" {
      + access_key         = (known after apply)
      + acl                = "public-read"
      + bucket             = "ingvar78-netology-bucket"
      + bucket_domain_name = (known after apply)
      + force_destroy      = false
      + id                 = (known after apply)
      + secret_key         = (sensitive value)
      + website_domain     = (known after apply)
      + website_endpoint   = (known after apply)

      + server_side_encryption_configuration {
          + rule {
              + apply_server_side_encryption_by_default {
                  + kms_master_key_id = (known after apply)
                  + sse_algorithm     = "aws:kms"
                }
            }
        }

      + versioning {
          + enabled = (known after apply)
        }
    }

  # yandex_storage_object.pictures will be created
  + resource "yandex_storage_object" "pictures" {
      + access_key   = (known after apply)
      + acl          = "public-read"
      + bucket       = "ingvar78-netology-bucket"
      + content_type = (known after apply)
      + id           = (known after apply)
      + key          = "test_pic.jpg"
      + secret_key   = (sensitive value)
      + source       = "./img/maxresdefault.jpg"
    }

Plan: 7 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bucket_domain_name = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_iam_service_account.sa-bucket: Creating...
yandex_kms_symmetric_key.key-a: Creating...
yandex_kms_symmetric_key.key-a: Creation complete after 1s [id=abjmmca4qpg736nku2ur]
yandex_iam_service_account.sa-bucket: Creation complete after 1s [id=ajec2urge0fagjici7pu]
yandex_iam_service_account_static_access_key.sa-static-key: Creating...
yandex_resourcemanager_folder_iam_member.sa-editor: Creating...
yandex_resourcemanager_folder_iam_member.kms-user: Creating...
yandex_iam_service_account_static_access_key.sa-static-key: Creation complete after 1s [id=aje1eivcv3fc4uv68b3p]
yandex_storage_bucket.netology-bucket: Creating...
yandex_resourcemanager_folder_iam_member.kms-user: Creation complete after 1s [id=b1gm6im3mcuc36r6kn8s/kms.keys.encrypterDecrypter/serviceAccount:ajec2urge0fagjici7pu]
yandex_resourcemanager_folder_iam_member.sa-editor: Creation complete after 3s [id=b1gm6im3mcuc36r6kn8s/editor/serviceAccount:ajec2urge0fagjici7pu]
yandex_storage_bucket.netology-bucket: Creation complete after 4s [id=ingvar78-netology-bucket]
yandex_storage_object.pictures: Creating...
yandex_storage_object.pictures: Creation complete after 1s [id=test_pic.jpg]

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

bucket_domain_name = "https://ingvar78-netology-bucket.storage.yandexcloud.net/test_pic.jpg"

```


```
iva@c9v:~/Documents/15.3 $ yc kms symmetric-key list
+----------------------+----------+----------------------+-------------------+---------------------+--------+
|          ID          |   NAME   |  PRIMARY VERSION ID  | DEFAULT ALGORITHM |     CREATED AT      | STATUS |
+----------------------+----------+----------------------+-------------------+---------------------+--------+
| abjmmca4qpg736nku2ur | test-key | abj51k9v9052vk85obr2 | AES_128           | 2023-01-06 21:19:33 | ACTIVE |
+----------------------+----------+----------------------+-------------------+---------------------+--------+

```

```
iva@c9v:~/Documents/15.3 $ yc iam service-account list
+----------------------+---------------+
|          ID          |     NAME      |
+----------------------+---------------+
| ajec2urge0fagjici7pu | sa-for-bucket |
| ajer71d7eocvuvuvo86j | neto-robot    |
+----------------------+---------------+

iva@c9v:~/Documents/15.3 $ yc resource-manager folder list-access-bindings netology
+-----------------------------+----------------+----------------------+
|           ROLE ID           |  SUBJECT TYPE  |      SUBJECT ID      |
+-----------------------------+----------------+----------------------+
| editor                      | serviceAccount | ajec2urge0fagjici7pu |
| kms.keys.encrypterDecrypter | serviceAccount | ajec2urge0fagjici7pu |
| admin                       | serviceAccount | ajer71d7eocvuvuvo86j |
| editor                      | serviceAccount | ajer71d7eocvuvuvo86j |
+-----------------------------+----------------+----------------------+

```