variable "cidr_blocks" { 
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] 
}

variable "vpc_private_subnets" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnets" {
    type = list(string)
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "vpc_azs" {
    type = list(string)
    default = ["us-east-1a", "us-east-1b" ]
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "dns_hostnames" {
    default = "true"
}

 
variable "ingress" {
    type = list(number)
    default = [22,80,443,8080]
}

variable "egress" {
    type = list(number)
    default = [80,443]
}

variable "username" {
  type        = string
  description = ""
}

variable "password" {
  type        = string
  description = ""
  sensitive   = true
}

variable "instance_class" {
  type        = string
  description = ""
}


variable "engine" {
  type        = string
  description = ""
}

variable "allocated_storage" {
  type        = string
  description = ""
}
