# -------------------------
# MSK Cluster
# -------------------------

resource "aws_msk_cluster" "kafka" {
  cluster_name           = "shopyyy-msk"
  kafka_version          = "3.6.0"
  number_of_broker_nodes = 2

  broker_node_group_info {

    instance_type   = var.instance_type
    client_subnets  = var.private_subnets
    security_groups = [var.msk_sg]

    storage_info {
      ebs_storage_info {
        volume_size = 100
      }
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "PLAINTEXT"
      in_cluster    = false
    }
  }
}
