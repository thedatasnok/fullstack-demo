provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "app" {
  source = "./modules/app"
  namespace = var.namespace
  app_version = var.app_version
  hostname = var.hostname
  cluster_issuer = var.cluster_issuer
}
