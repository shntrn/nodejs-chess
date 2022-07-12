resource "azurerm_resource_group" "cluster_rg" {
  name     = var.clustername
  location = var.cluster_location 

  tags = merge(var.common_tags, {Type = "Resource Group"})
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.cluster_rg.name
  location            = var.cluster_location 
  sku                 = "Standard"
  admin_enabled       = true
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
    type                = "VirtualMachineScaleSets"
    availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
    enable_node_public_ip = true
  }

  identity {
    type = "SystemAssigned"
  }

   network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet" # CNI
  }

  tags = merge(var.common_tags, {Type = "Cluster"})

}

resource "azurerm_role_assignment" "kubweb_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}

resource "azurerm_public_ip" "ip" {
  name = var.ipname
  resource_group_name = azurerm_resource_group.cluster_rg.name
  location =  azurerm_resource_group.cluster_rg.location
  allocation_method = "Static"

  tags = merge(var.common_tags, {Type = "IP"})
}

resource "azurerm_role_assignment" "network_to_kuber" {
  principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  role_definition_name = "Network Contributor"
  scope = "/subscriptions/a58e1ad6-4c01-448d-b0ef-3ef07be7e3cd/resourceGroups/${azurerm_public_ip.ip.resource_group_name}"

}


