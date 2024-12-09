resource "kubernetes_deployment" "release_management_examples_blue" {
  count = var.blue_active ? 1 : 0

  metadata {
    name = "release-management-examples-blue"
    namespace = kubernetes_namespace.release_management_examples.metadata[0].name
    labels = {
      app = "release-management-examples-blue"
      env = local.env
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "release-management-examples-blue"
      }
    }

    template {
      metadata {
        labels = {
          app = "release-management-examples-blue"
          env = local.env
        }
      }

      spec {
        container {
          image = "release-management-examples:${var.blue_tag}"
          name  = "release-management-examples"
          image_pull_policy = "IfNotPresent"

          command = ["poetry", "run", "python", "app.py"]

          port {
            container_port = local.server_port
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.release_management_examples.metadata[0].name
            }
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "0.5"
              memory = "512Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/api"
              port = local.server_port
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "release_management_examples_green" {
  count = var.green_active ? 1 : 0

  metadata {
    name = "release-management-examples-green"
    namespace = kubernetes_namespace.release_management_examples.metadata[0].name
    labels = {
      app = "release-management-examples-green"
      env = local.env
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "release-management-examples-green"
      }
    }

    template {
      metadata {
        labels = {
          app = "release-management-examples-green"
          env = local.env
        }
      }

      spec {
        container {
          image = "release-management-examples:${var.green_tag}"
          name  = "release-management-examples"
          image_pull_policy = "IfNotPresent"

          command = ["poetry", "run", "python", "app.py"]

          port {
            container_port = local.server_port
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.release_management_examples.metadata[0].name
            }
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "0.5"
              memory = "512Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/api"
              port = local.server_port
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

