variable "vpc_cidr" {
    default = "10.0.0.0/16"
    description = "This the VPC in which we create the instances"
  
}

variable "subnet1" {
    default = "10.1.0.0/24"
    description = "This is the first subnet"
  
}

variable "subnet2" {
    default = "10.0.0.0/24"
    description = "This is my second subnet"
  
}