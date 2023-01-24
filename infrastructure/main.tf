provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "core" {
  source           = "./modules/core"
  environment_name = var.environment_name
}

module "app" {
  source    = "./modules/app"
  namespace = module.core.namespace
}
