variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "cidr_ipv4" {
    default = "0.0.0.0/0"
}
variable "ip_protocol" {
    default = "-1"
}