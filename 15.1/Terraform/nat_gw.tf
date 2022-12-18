#Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1
resource "yandex_compute_instance" "natgw" {
  name                      = "natgw"
  zone                      = "ru-central1-a"
  hostname                  = "ngw.netology.yc"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 1
    core_fraction = "20"
  }

  boot_disk {
    initialize_params {
      image_id    = var.nat_gw_img
      name        = "natgw254"
      type        = "network-hdd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet_pub.id
    nat            = true
    ip_address = "192.168.10.254"
  }

  scheduling_policy {
    preemptible = true  // Прерываемая ВМ

  }

  metadata = {
    #ssh-keys = "centos:${file(var.pub_key_path)}"
    user-data = "${file(var.meta_file)}"
  }
}