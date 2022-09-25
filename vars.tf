
variable "Environment" {
  type = string
  default = "Staging"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "PublicSubnetsCidr" {
  type = list(string)
  default = ["10.0.0.0/19","10.0.32.0/19"]
}

variable "PrivateSubnetsCidr" {
  type = list(string)
  default= ["10.0.128.0/19","10.0.160.0/19"]
}

variable "ami_image" {
  type = string
  default= "i-007c12c0bb2bd04c0"
}
