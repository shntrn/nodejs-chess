#Values for cluster

variable "clustername" {
    default = "node-js-cluster"
}

variable "nodepool_name" {
    default = "nodejsschess"
}

variable "cluster_location" {     
    default = "Central US"
}

variable "common_tags" {
    type = map
    default = {
        Project = "Cluster NodeJS"
        Owner   = "Egor Shantarin"
    }
}