module "nodejs_chess_cluster" {
  source       = "./cluster"
   
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf_rg_blobstore"
    storage_account_name = "tfnodejsstore"
    container_name       = "tfstatecontainer"
    key                  = "terraform.tfstate"
  }
}