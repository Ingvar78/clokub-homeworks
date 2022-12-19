# Домашнее задание к занятию "15.1. Организация сети"

Домашнее задание будет состоять из обязательной части, которую необходимо выполнить на провайдере Яндекс.Облако и дополнительной части в AWS по желанию. Все домашние задания в 15 блоке связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
Все задания требуется выполнить с помощью Terraform, результатом выполненного домашнего задания будет код в репозитории. 

Перед началом работ следует настроить доступ до облачных ресурсов из Terraform используя материалы прошлых лекций и [ДЗ](https://github.com/netology-code/virt-homeworks/tree/master/07-terraform-02-syntax ). А также заранее выбрать регион (в случае AWS) и зону.

---
## Задание 1. Яндекс.Облако (обязательное к выполнению)

1. Создать VPC.
- Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 192.168.10.0/24.
- Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1
- Создать в этой публичной подсети виртуалку с публичным IP и подключиться к ней, убедиться что есть доступ к интернету.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 192.168.20.0/24.
- Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс
- Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее и убедиться что есть доступ к интернету

Resource terraform для ЯО
- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet)
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table)
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance)
- [Маршрутизация с помощью NAT-инстанса](https://cloud.yandex.ru/docs/vpc/tutorials/nat-instance#create-nat-instance)
---

## Решение Задания 1.

[terraform](./Terraform/)

<details>
    <summary>Решение задачи 1</summary>

```
iva@c9v:~/Documents/15 $ cat versions.tf 
terraform {
  required_providers {
    yandex = {
      source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "neto-ingvar78"
    region                      = "us-east-1"
    key                         = "terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }

  required_version = ">= 1.1"
}

iva@c9v:~/Documents/15 $ terraform --version
Terraform v1.3.6
on linux_amd64
+ provider terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex v0.72.0

```

```
iva@c9v:~/Documents/15 $ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "empty"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_network.subnet_pub will be created
  + resource "yandex_vpc_network" "subnet_pub" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "public"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet_pub will be created
  + resource "yandex_vpc_subnet" "subnet_pub" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "public"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
iva@c9v:~/Documents/15 $ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "empty"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_network.subnet_pub will be created
  + resource "yandex_vpc_network" "subnet_pub" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "public"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet_pub will be created
  + resource "yandex_vpc_subnet" "subnet_pub" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "public"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_vpc_network.default: Creating...
yandex_vpc_network.subnet_pub: Creating...
yandex_vpc_network.default: Creation complete after 2s [id=enpsmuh4cst4c5te366s]
yandex_vpc_network.subnet_pub: Creation complete after 2s [id=enp54lgte3ti0o2rcplb]
yandex_vpc_subnet.subnet_pub: Creating...
yandex_vpc_subnet.subnet_pub: Creation complete after 1s [id=e9bkqkj8v31qhdutal2d]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

```

```

iva@c9v:~/Documents/15 $ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.natgw will be created
  + resource "yandex_compute_instance" "natgw" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "ngw.netology.yc"
      + id                        = (known after apply)
      + metadata                  = {
          + "user-data" = <<-EOT
                #cloud-config
                users:
                  - name: ansible
                    groups: sudo
                    shell: /bin/bash
                    sudo: ['ALL=(ALL) NOPASSWD:ALL']
                    ssh-authorized-keys:
                      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCoIlqTa8IYoXlkfdGZroeEOf<cut>
                
            EOT
        }
      + name                      = "natgw"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd80mrhj8fl2oe87o4e1"
              + name        = "natgw254"
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "192.168.10.254"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + placement_group_id = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "empty"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_network.subnet_pub will be created
  + resource "yandex_vpc_network" "subnet_pub" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "public"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet_pub will be created
  + resource "yandex_vpc_subnet" "subnet_pub" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "public"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 4 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.


iva@c9v:~ $ ssh ansible@51.250.0.159
Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-29-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

New release '20.04.5 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



#################################################################
This instance runs Yandex.Cloud Marketplace product
Please wait while we configure your product...

Documentation for Yandex Cloud Marketplace images available at https://cloud.yandex.ru/docs

#################################################################

Last login: Sun Dec 18 21:53:33 2022 from 95.31.137.252
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ansible@ngw:~$ ping google.com
PING google.com (172.217.169.206) 56(84) bytes of data.
64 bytes from sof02s34-in-f14.1e100.net (172.217.169.206): icmp_seq=1 ttl=61 time=65.6 ms
64 bytes from sof02s34-in-f14.1e100.net (172.217.169.206): icmp_seq=2 ttl=61 time=65.4 ms
64 bytes from sof02s34-in-f14.1e100.net (172.217.169.206): icmp_seq=3 ttl=61 time=65.3 ms
64 bytes from sof02s34-in-f14.1e100.net (172.217.169.206): icmp_seq=4 ttl=61 time=65.3 ms
^C
--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 65.334/65.435/65.602/0.101 ms
ansible@ngw:~$ 

```

```
va@c9v:~ $ ssh ansible@51.250.65.175
Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-29-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

New release '20.04.5 LTS' available.
Run 'do-release-upgrade' to upgrade to it.



#################################################################
This instance runs Yandex.Cloud Marketplace product
Please wait while we configure your product...

Documentation for Yandex Cloud Marketplace images available at https://cloud.yandex.ru/docs

#################################################################

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ansible@ngw:~$ cd .ssh/
ansible@ngw:~/.ssh$ chmod 600 id_rsa*
ansible@ngw:~/.ssh$ ssh ansible@192.168.20.17
The authenticity of host '192.168.20.17 (192.168.20.17)' can't be established.
ECDSA key fingerprint is SHA256:K2n0oHXHiNL8lg/fCa0NOl/ZAH7ab09FKbBIHa6bKG8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.20.17' (ECDSA) to the list of known hosts.
[ansible@private ~]$ ping ya.ru
PING ya.ru (87.250.250.242) 56(84) bytes of data.
64 bytes from ya.ru (87.250.250.242): icmp_seq=1 ttl=56 time=25.8 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=2 ttl=56 time=3.88 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=3 ttl=56 time=3.85 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=4 ttl=56 time=3.79 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=5 ttl=56 time=3.82 ms
^C
--- ya.ru ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4007ms
rtt min/avg/max/mdev = 3.791/8.237/25.843/8.803 ms
[ansible@private ~]$ ip route
default via 192.168.20.1 dev eth0 proto dhcp metric 100 
192.168.20.0/24 dev eth0 proto kernel scope link src 192.168.20.17 metric 100 
[ansible@private ~]$ ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.20.17  netmask 255.255.255.0  broadcast 192.168.20.255
        inet6 fe80::d20d:62ff:feb5:d47d  prefixlen 64  scopeid 0x20<link>
        ether d0:0d:62:b5:d4:7d  txqueuelen 100000  (Ethernet)
        RX packets 412  bytes 38388 (37.4 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 422  bytes 37029 (36.1 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 70  bytes 6048 (5.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 70  bytes 6048 (5.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

[ansible@private ~]$ exit
logout
Connection to 192.168.20.17 closed.
ansible@ngw:~/.ssh$ exit

```
</details>



<details>
    <summary>Скриншоты задачи 1</summary>
    

![](./Img/Route-to-nat.png)
![](./Img/Route-to-nat-yc01.png)
![](./Img/Route-to-nat-yc.png)


</details>



## Задание 2*. AWS (необязательное к выполнению)

1. Создать VPC.
- Cоздать пустую VPC с подсетью 10.10.0.0/16.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 10.10.1.0/24
- Разрешить в данной subnet присвоение public IP по-умолчанию. 
- Создать Internet gateway 
- Добавить в таблицу маршрутизации маршрут, направляющий весь исходящий трафик в Internet gateway.
- Создать security group с разрешающими правилами на SSH и ICMP. Привязать данную security-group на все создаваемые в данном ДЗ виртуалки
- Создать в этой подсети виртуалку и убедиться, что инстанс имеет публичный IP. Подключиться к ней, убедиться что есть доступ к интернету.
- Добавить NAT gateway в public subnet.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 10.10.2.0/24
- Создать отдельную таблицу маршрутизации и привязать ее к private-подсети
- Добавить Route, направляющий весь исходящий трафик private сети в NAT.
- Создать виртуалку в приватной сети.
- Подключиться к ней по SSH по приватному IP через виртуалку, созданную ранее в публичной подсети и убедиться, что с виртуалки есть выход в интернет.

Resource terraform
- [VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
- [Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
- [Internet Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)
