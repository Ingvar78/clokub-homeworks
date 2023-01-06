# https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer
data "yandex_compute_image" "img_nlb_lamp" {
  family = "lamp"
}

resource "yandex_compute_instance_group" "inst-nlb" {
  name               = "instance-for-nlb"
  folder_id          = var.yc_folder_id
  service_account_id = "${yandex_iam_service_account.sa-bucket.id}"
  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = 1
      cores  = 2
      core_fraction = 20
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.lamp_image
        type     = "network-hdd"
        size     = 20
      }
    }

    network_interface {
      network_id = yandex_vpc_network.default.id
      subnet_ids = [yandex_vpc_subnet.priv_subnet.id]
      nat        = false
      ipv6       = false
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
      user-data = <<-EOF
        #!/bin/bash
        echo "<html><p>Netwrok Load Balancer on "`hostname`"</p><img src="https://storage.yandexcloud.net/${yandex_storage_bucket.netology-bucket.bucket}/${yandex_storage_object.pictures.key}"></html>" > /var/www/html/index.html
      EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_creating     = 3
    max_deleting     = 3
    max_unavailable  = 1
    max_expansion    = 0
    # startup_duration = 10
  }

  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "load balancer target group"
  }
}
