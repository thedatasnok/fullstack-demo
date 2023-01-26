terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "github" {
  token = var.github_token
}

locals {
  gh_repository = "thedatasnok/fullstack-demo"
}

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

resource "github_repository_environment" "gh_environment" {
  repository  = local.gh_repository
  environment = var.environment_name
}

resource "github_actions_environment_secret" "gh_environment_k8s_secret" {
  repository      = local.gh_repository
  environment     = github_repository_environment.gh_environment.environment
  secret_name     = "K8S_SECRET"
  plaintext_value = kubernetes_secret.service_account_token.data.token
}

# NOTE: These resources are fictive, the GitHub provider currently does not support adding environment variables to environments

# resource "github_actions_environment_variable" "gh_environment_k8s_namespace" {
#   repository      = local.gh_repository
#   environment     = github_repository_environment.gh_environment.environment
#   variable_name   = "NAMESPACE"
#   plaintext_value = kubernetes_namespace.k8s_ns.metadata.0.name
# }

# resource "github_actions_environment_variable" "gh_environment_k8s_server" {
#   repository      = local.gh_repository
#   environment     = github_repository_environment.gh_environment.environment
#   variable_name   = "K8S_API_URL"
#   plaintext_value = ""
# }

# resource "github_actions_environment_variable" "gh_environment_k8s_cluster_issuer" {
#   repository      = local.gh_repository
#   environment     = github_repository_environment.gh_environment.environment
#   variable_name   = "CLUSTER_ISSUER"
#   plaintext_value = "letsencrypt"
# }

# resource "github_actions_environment_variable" "gh_environment_hostname" {
#   repository      = local.gh_repository
#   environment     = github_repository_environment.gh_environment.environment
#   variable_name   = "HOSTNAME"
#   plaintext_value = "" 
# }
