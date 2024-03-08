variable "subnet_id_1" {}
variable "subnet_id_2" {}
variable "sg_id" {
    type = string
}
variable "port" {
    default = "80"
}
variable "http" {
    default = "HTTP"
}
variable "target_id" {}
variable "vpc_id" {}