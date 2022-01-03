#EC2 mod vars
variable "ami" {
  type    = string
  default = "ami-01cc34ab2709337aa"

}
variable "inst_type" {
  type    = string
  default = "t2.micro"

}
variable "key" {
  type    = string
  default = "tf-demo"
}
variable "vpc_id_1" {
  type    = string
  default = ""
}
variable "vpc_id_2" {
  type    = string
  default = ""
}
variable "SG" {
  type    = string
  default = ""
}
variable "path"{
        type=string
        default="/etc/ansible/roles/tf-demo.pem"
}
