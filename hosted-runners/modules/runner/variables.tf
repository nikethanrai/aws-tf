variable "name_prefix" {
    type = string
  
}

variable "private_subnet_id" {
    type = string
  
}

variable "instance_type" {
    type = string
    default = "t3.micro"
  
}

variable "min_size" {
    type = number
    default = 0
  
}

variable "max_size" {
    type = number
    default = 0
}

variable "desired_capacity" {
    type = number
    default = 0
  
}