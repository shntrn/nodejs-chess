#Values for production resource group

variable "group_name" {
    default = "nodejschess-group"
}

variable "location" {
    default = "Central US"
}

variable "storage_name" {
    default = "nodejsschessweb"
}

variable "db_name" {
    default = "nodejs-chess-db"
}

variable "backend_tier" {
    default = "Basic"
}

variable "backend_size" {
    default = "B1"
}

variable "backend_name" {
    default = "nodejs-chess-backend"
}

variable "backend_port" {
    type = number
    default = 8081
}

variable "backend_ver" {
    default = "NODE|14-lts"
}

variable "common_tags" {
    type = map
    default = {
        Project = "NodeJS Chess"
        Owner = "Egor Shantarin"
    }
}
