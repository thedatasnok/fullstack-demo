provider "kubernetes" {
  config_path = var.kubeconfig_path
  insecure    = true # This is apparently required for it to work in GitHub Actions?
}

module "app" {
  source         = "./modules/app"
  namespace      = var.namespace
  app_version    = var.app_version
  hostname       = var.hostname
  cluster_issuer = var.cluster_issuer
}
