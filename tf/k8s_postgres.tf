
resource "kubernetes_stateful_set" "postgres" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace.release_management_examples.metadata[0].name
  }

  spec {
    replicas               = 1
    revision_history_limit = 5

    selector {
      match_labels = {
        app = "postgres"
      }
    }

    service_name = "postgres"

    template {
      metadata {
        labels = {
          app = "postgres"
          env = local.env
        }

        annotations = {}
      }

      spec {
        container {
          name              = "postgres"
          image             = "postgres"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 5432
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.postgres.metadata[0].name
            }
          }

          #   resources {
          #     limits = {
          #       cpu    = "10m"
          #       memory = "10Mi"
          #     }

          #     requests = {
          #       cpu    = "10m"
          #       memory = "10Mi"
          #     }
          #   }
        }
      }
    }

    update_strategy {
      type = "RollingUpdate"

      rolling_update {
        partition = 1
      }
    }

    volume_claim_template {
      metadata {
        name = "postgres-${local.env}"
        labels = {
          env = local.env
        }
      }

      spec {
        access_modes       = ["ReadWriteMany"]
        storage_class_name = "standard"

        selector {
          match_labels = {
            env = local.env
            app = "postgres"
          }
        }

        resources {
          requests = {
            storage = "1Gi"
          }
        }
      }
    }

  }
}

resource "kubernetes_persistent_volume" "postgres" {
  metadata {
    name = "release-management-examples-postgres-${local.env}"
    labels = {
      app = "postgres"
      env = local.env
    }
  }
  spec {
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      host_path {
        path = "/mnt/data/docker/pvcs/release-management-examples-postgres-${local.env}"
        type = "DirectoryOrCreate"
      }
    }
    capacity = {
      storage = "5Gi"
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_config_map" "postgres" {
  metadata {
    name      = "postgres-config"
    namespace = kubernetes_namespace.release_management_examples.metadata[0].name
    labels = {
      app = "postgres"
      env = local.env
    }
  }

  data = {
    POSTGRES_DB       = local.postgres_db
    POSTGRES_USER     = local.postgres_user
    POSTGRES_PASSWORD = var.postgres_password
  }
}

resource "kubernetes_service" "postgres_5432" {
  metadata {
    name      = "postgres-5432"
    namespace = kubernetes_namespace.release_management_examples.metadata[0].name
    labels = {
      app = "postgres"
      env = local.env
    }
  }
  spec {
    port {
      port     = 5432
      protocol = "TCP"
    }
    type = "ClusterIP"
    selector = {
      app = "postgres"
    }
  }
}
