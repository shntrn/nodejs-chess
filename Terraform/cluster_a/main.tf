resource "azurerm_resource_group" "cluster_rg" {
  name     = var.clustername
  location = var.cluster_location 

  tags = merge(var.common_tags, {Type = "Resource Group"})
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.clustername
  location            = var.cluster_location 
  resource_group_name = azurerm_resource_group.cluster_rg.name
  dns_prefix          = var.clustername

  default_node_pool {
    name       = var.nodepool_name
    node_count = "1"
    vm_size    = "Standard_D2as_v5"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(var.common_tags, {Type = "Cluster"})

}