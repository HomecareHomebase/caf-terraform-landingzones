# resource "kubernetes_namespace" "namespaces1" {
#     for_each = try(local.clusters[var.cluster_re1_key], null) != null ? { (var.cluster_re1_key) = local.clusters[var.cluster_re1_key] } : {}
  
#   metadata {
#     annotations = try(var.namespace.annotations, null)
#     labels      = try(var.namespace.labels, null)
#     name        = var.namespace.name
#   }

#   provider = kubernetes.k8s1
# }

# resource "kubernetes_namespace" "namespaces2" {
#   for_each = try(local.clusters[var.cluster_re1_key], null) != null ? { (var.cluster_re1_key) = local.clusters[var.cluster_re1_key] } : {}

#   metadata {
#     annotations = try(var.namespace.annotations, null)
#     labels      = try(var.namespace.labels, null)
#     name        = var.namespace.name
#   }

#   provider = kubernetes.k8s2
# }