module "flux1" {
  source   = "./modules/flux"
  for_each = try(local.clusters[var.cluster_re1_key], null) != null ? { (var.cluster_re1_key) = local.clusters[var.cluster_re1_key] } : {}

  cluster     = each.value
  namespace  = var.namespace

  target_path = var.flux[each.key].target_path //lookup(var.flux, each.key, { target_path = null}).target_path
  repository_url = var.flux[each.key].repository_url // lookup(var.flux, each.key, { repository_url = null}).repository_url
  branch = try(var.flux[each.key].branch, "master") // var.flux, each.key, { branch = "master"}).branch
  git_implementation = try(var.flux[each.key].git_implementation, "libgit2")  //lookup(var.flux, each.key, { git_implementation = "libgit2"}).git_implementation

  # target_path = lookup(var.flux, each.key, { target_path = null}).target_path
  # repository_url = lookup(var.flux, each.key, { repository_url = null}).repository_url
  # branch = lookup(var.flux, each.key, { branch = "master"}).branch
  # git_implementation = lookup(var.flux, each.key, { git_implementation = "libgit2"}).git_implementation

  # depends_on = [
  #   kubernetes_namespace.namespaces1
  # ]

  providers = {
    kubernetes = kubernetes.k8s1
    kubectl = kubectl.kubectl1
    flux = flux.flux1
  }
}

module "flux2" {
  source   = "./modules/flux"
  for_each = try(local.clusters[var.cluster_re2_key], null) != null ? { (var.cluster_re2_key) = local.clusters[var.cluster_re2_key] } : {}

  cluster     = each.value
  namespace  = var.namespace
  target_path = var.flux[each.key].target_path //lookup(var.flux, each.key, { target_path = null}).target_path
  repository_url = var.flux[each.key].repository_url // lookup(var.flux, each.key, { repository_url = null}).repository_url
  branch = try(var.flux[each.key].branch, "master") // var.flux, each.key, { branch = "master"}).branch
  git_implementation = try(var.flux[each.key].git_implementation, "libgit2")  //lookup(var.flux, each.key, { git_implementation = "libgit2"}).git_implementation

  # depends_on = [
  #   kubernetes_namespace.namespaces2
  # ]

  providers = {
    kubernetes = kubernetes.k8s2
    kubectl = kubectl.kubectl2
    flux = flux.flux2
  }
}