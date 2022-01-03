variable "region"{
        type=string
        default = "us-east-1"
}
variable "profile"{
        type=string
        default="tf_demo"
}
variable "public_ip"{
	type=string
	default=""
}
variable "path"{
	type=string
	default="/etc/ansible/roles/tf-demo.pem"
}
