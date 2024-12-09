locals {
  env = terraform.workspace

  flask_env = "development"
  flask_app = "app"
  server_port  = 5003


  postgres_host = "postgres-5432.release-management-examples-local.svc.cluster.local"
  postgres_user = "dev"
  postgres_db   = "release-management-examples"
}
