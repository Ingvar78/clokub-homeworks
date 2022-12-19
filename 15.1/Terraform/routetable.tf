#Route table

resource "yandex_vpc_route_table" "lab-rt-a" {
  name       = "route-to-nat"
  network_id = "${yandex_vpc_network.default.id}"
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.natgw.network_interface.0.ip_address
  }
}