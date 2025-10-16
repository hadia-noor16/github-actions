variable "vpc_cidr" {
    type = string
}
variable "vpc_name" {
    type = string
}
variable "cidr_public_subnet" {
    type = list(string)
}
variable "cidr_private_subnet" {
    type = list(string)
}
variable "availability_zone" {
    type = list(string)
}
variable "demokey" {
    type = string
}
variable "ec2_ami" {
    type = string
}