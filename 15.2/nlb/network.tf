resource "yandex_vpc_network" "default" {
  name        = "vpc_network"
  description = "My VPC Network"
}

resource "yandex_vpc_subnet" "pub_subnet" {
  name           = "public-subnet"
  description    = "My public subnet"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.default.id}"
}



resource "yandex_vpc_subnet" "priv_subnet" {
  name           = "private-subnet"
  description    = "My private subnet"
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
}