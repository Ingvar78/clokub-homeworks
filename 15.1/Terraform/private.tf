#Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее и убедиться что есть доступ к интернету
resource "yandex_compute_instance" "private" {
  name                      = "private"
  zone                      = "ru-central1-b"
  hostname                  = "private.netology.yc"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 1
    core_fraction = "20"
  }

  boot_disk {
    initialize_params {
      image_id    = var.centos-7-base
      name        = "private17"
      type        = "network-hdd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.priv_subnet.id
    nat            = false
    ip_address = "192.168.20.17"
  }

  scheduling_policy {
    preemptible = true  // Прерываемая ВМ

  }

  metadata = {
    #ssh-keys = "centos:${file(var.pub_key_path)}"
    user-data = "${file(var.meta_file)}"
  }
}