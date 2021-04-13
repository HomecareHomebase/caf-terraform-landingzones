# data "flux_install" "flux" {
#   target_path = var.target_path
#   version = "v0.11.0"
#   registry = "ghcr.io/fluxcd"
# }

# data "flux_sync" "flux" {
#   target_path        = var.target_path
#   url                = var.repository_url
#   branch             = var.branch
#   git_implementation = var.git_implementation
# }

resource "kubernetes_namespace" "flux_system" {

  metadata {
    name = var.namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

# data "kubectl_file_documents" "install" {
#   content = data.flux_install.flux.content
# }

# data "kubectl_file_documents" "sync" {
#   content = data.flux_sync.flux.content
# }

# locals {
#   install = [for v in data.kubectl_file_documents.install.documents : {
#     data : yamldecode(v)
#     content : v
#     }
#   ]
#   sync = [for v in data.kubectl_file_documents.sync.documents : {
#     data : yamldecode(v)
#     content : v
#     }
#   ]
# }

# resource "kubectl_manifest" "install" {
#   for_each   = { for v in local.install : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
#   depends_on = [kubernetes_namespace.flux_system]
#   yaml_body  = each.value
# }

# resource "kubectl_manifest" "sync" {
#   for_each   = { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }
#   depends_on = [kubernetes_namespace.flux_system]
#   yaml_body  = each.value
# }

# # resource "kubernetes_secret" "main" {
# #   for_each = try(local.clusters[var.cluster_re1_key], null) != null ? { (var.cluster_re1_key) = local.clusters[var.cluster_re1_key] } : {}

# #   depends_on = [kubectl_manifest.install]

# #   metadata {
# #     name      = data.flux_sync.main[each.key].secret
# #     namespace = data.flux_sync.main[each.key].namespace
# #   }

# #   data = {
# #     username = "git"
# #     password = var.flux_token
# #   }
# # }

# # data "kubectl_file_documents" "install" {
# #   for_each = try(local.clusters[var.cluster_re1_key], null) != null ? { (var.cluster_re1_key) = local.clusters[var.cluster_re1_key] } : {}

# #   content = data.flux_install.main[each.key].content
# # }

# # locals {
# #   sync = [ for v in data.kubectl_file_documents.install[var.cluster_re1_key].documents : {
# #       data: yamldecode(v)
# #       content: v
# #     }
# #   ]
# # }

# # resource "kubectl_manifest" "install" {
# #   for_each   = { for v in local.sync : lower(join("/", compact([v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name]))) => v.content }

# #   depends_on = [kubernetes_namespace.flux_system]

# #   yaml_body = each.value
# # }

# # resource "kubernetes_secret" "main" {
# #   for_each = try(local.clusters[var.cluster_re1_key], null) != null ? { (var.cluster_re1_key) = local.clusters[var.cluster_re1_key] } : {}

# #   depends_on = [kubectl_manifest.install]

# #   metadata {
# #     name      = data.flux_sync.main.secret
# #     namespace = data.flux_sync.main.namespace
# #   }

# #   data = {
# #     username = "git"
# #     password = var.flux_token
# #   }
# # }