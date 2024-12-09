resource "kubernetes_namespace" "release_management_examples" {
  metadata {
    name = "release-management-examples-${local.env}"
  }
}
