variable "name_prefix" {
    description = "Prefix applied to all resources names/tags"
    type = string
  
}

variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type = string
    default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
    description = "CIDR block for the public subnet"
    type = string
    default = "10.0.0.0/24"
  
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  default = "10.0.1.0/24"
}

variable "availability_zone" {
    description = "Az to place both subnet sin single az"
    type = string
    default = "ap-southeast-2a"
}