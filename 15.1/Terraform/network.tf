#15.1.1 Создать пустую VPC
resource "yandex_vpc_network" "default" {
  name = "empty"
}

#15.1.2 Создать в vpc subnet с названием public, сетью 192.168.10.0/24.
resource "yandex_vpc_network" "subnet_pub" {
  name = "public"
}

resource "yandex_vpc_subnet" "subnet_pub" {
  name           = "public"
  network_id     = resource.yandex_vpc_network.subnet_pub.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
}
