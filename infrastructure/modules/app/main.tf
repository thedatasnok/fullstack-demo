/*
  This module encapsulates everything needed to deploy the application.
  It is required to apply the "core" module first, if a namespace and secret are not yet present.
*/

locals {
  app_selector = "fullstack-demo"
}

# - DEPLOYMENTS

resource "kubernetes_deployment" "backend_deployment" {
  metadata {
    name      = "backend"
    namespace = var.namespace
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = local.app_selector
      }
    }
    template {
      metadata {
        labels = {
          app = local.app_selector
        }
      }
      spec {
        container {
          image = format("ghcr.io/thedatasnok/fullstack-demo-backend:%s", var.app_version)
          name  = "backend-container"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "frontend_deployment" {
  metadata {
    name      = "frontend"
    namespace = var.namespace
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = local.app_selector
      }
    }
    template {
      metadata {
        labels = {
          app = local.app_selector
        }
      }
      spec {
        container {
          image = format("ghcr.io/thedatasnok/fullstack-demo-frontend:%s", var.app_version)
          name  = "frontend-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# - SERVICES

resource "kubernetes_service" "backend_service" {
  metadata {
    name      = "backend"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = local.app_selector
    }
    port {
      port        = 8080
      target_port = 8080
    }
  }
}

resource "kubernetes_service" "frontend_service" {
  metadata {
    name      = "frontend"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = local.app_selector
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

# - INGRESS

resource "kubernetes_ingress" "ingress" {
  metadata {
    name      = "ingress"
    namespace = var.namespace
    annotations = {
      "cert.manager.io/cluster-issuer"               = var.cluster_issuer
      "nginx.ingress.kubernetes.io/backend-protocol" = "HTTP"
    }
  }
  spec {
    rule {
      host = var.hostname
      http {
        path {
          path = "/"
          backend {
            service_name = kubernetes_service.frontend_service.metadata[0].name
            service_port = kubernetes_service.frontend_service.spec[0].port[0].port
          }
        }
        path {
          path = "/api"
          backend {
            service_name = kubernetes_service.backend_service.metadata[0].name
            service_port = kubernetes_service.backend_service.spec[0].port[0].port
          }
        }
      }
    }

    tls {
      hosts       = [var.hostname]
      secret_name = "fullstack-demo-ingress-cert"
    }
  }
}
