variable "kubeconfig_path" {
  type        = string
  description = "The path to the kubeconfig file to use for the Kubernetes provider."
  default     = "~/.kube/config"
}

variable "namespace" {
  type        = string
  description = "The namespace to deploy the app to."
}

variable "app_version" {
  type        = string
  description = "The version of the app to deploy."
}

variable "hostname" {
  type        = string
  description = "The hostname (FQDN) to deploy the app to."
}

variable "cluster_issuer" {
  type        = string
  description = "The name of the cluster issuer to use for TLS certificates"
}
