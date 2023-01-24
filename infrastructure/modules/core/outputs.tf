output "namespace" {
  value = kubernetes_namespace.k8s_ns.metadata.0.name
}
