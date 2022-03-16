terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token = "<iam-token>" # yc iam create-token  
  cloud_id  = "<cloud-id>"
  folder_id = var.folder-id
  zone      = "ru-central1-a"
}

variable "folder-id" {
  default = "<folder-id>"
}

resource "yandex_mdb_redis_cluster" "nursultan-cluster1994" {
  name                = "nursultan-cluster1994"
  environment         = "PRODUCTION" # environment: PRESTABLE or PRODUCTION
  network_id          = "<your-network-id>"
#  security_group_ids  = [ "<security group IDs>" ]   # if you have SG, you must write it here
  tls_enabled         = true
  sharded             = false # sharding: true or false
  deletion_protection = false # protect cluster from deletion: true or false 

  config {
    password = "<your-password>" # password
    version  = "6.0" # Redis version: 5.0 or 6.0
  }

  resources {
    resource_preset_id = "hm2.nano" # host class
    disk_type_id       = "network-ssd" # storage type
    disk_size          = 16 # storage size in GB
  }

  host {
    zone      = var.zone-choice # availability zone
    subnet_id = "<your-subnet-id>" #subnet ID
  }
}

