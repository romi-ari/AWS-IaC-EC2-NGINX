variable "region" {
    default = "us-east-1"
    type    = string
    description = "Default region" 
}

variable "az-1a" {
    default = "us-east-1a"
    type    = string
    description = "Availability Zone us-east-1a" 
}

variable "az-1b" {
    default = "us-east-1b"
    type    = string
    description = "Availability Zone us-east-1b" 
}

variable "instance-type" {
    default = "t2.micro"
    type    = string
    description = "EC2 instance types" 
}

