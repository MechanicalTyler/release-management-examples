resource "kubernetes_config_map" "release_management_examples" {
  metadata {
    name      = "release-management-examples-config"
    namespace = kubernetes_namespace.release_management_examples.metadata[0].name
    labels = {
      app = "searches"
      env = local.env
    }
  }

  data = {
    FLASK_APP = local.flask_app
    FLASK_ENV = local.flask_env

    POSTGRES_HOST     = local.postgres_host
    POSTGRES_USER     = local.postgres_user
    POSTGRES_PASSWORD = var.postgres_password
    POSTGRES_DB       = local.postgres_db

    FLASK_APP_SECRET_KEY = var.flask_app_secret

    SERVER_PORT = local.server_port
  }
}
