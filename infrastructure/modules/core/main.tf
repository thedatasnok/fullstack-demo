resource "kubernetes_namespace" "k8s_ns" {
  metadata {
    name = format("%s-%s", "demostack", var.environment_name)
  }
}

resource "kubernetes_service_account" "service_account" {
  metadata {
    name      = "workflows-sa"
    namespace = kubernetes_namespace.k8s_ns.metadata.0.name
  }
}

resource "kubernetes_role" "full_access_role" {
  metadata {
    name      = "full-access"
    namespace = kubernetes_namespace.k8s_ns.metadata.0.name
  }
  rule {
    api_groups = ["", "extensions", "apps", "networking.k8s.io"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_role_binding" "service_account_role_binding" {
  metadata {
    name      = "workflows-sa-full-access"
    namespace = kubernetes_namespace.k8s_ns.metadata.0.name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.full_access_role.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.service_account.metadata.0.name
    namespace = kubernetes_namespace.k8s_ns.metadata.0.name
  }
}

resource "kubernetes_secret" "service_account_token" {
  type = "kubernetes.io/service-account-token"
  metadata {
    name      = "workflows-sa-token"
    namespace = kubernetes_namespace.k8s_ns.metadata.0.name
    annotations = {
      "kubernetes.io/service-account.name" = kubernetes_service_account.service_account.metadata.0.name
    }
  }
}
