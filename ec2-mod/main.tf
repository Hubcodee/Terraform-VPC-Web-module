resource "tls_private_key" "ppk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key
  public_key = tls_private_key.ppk.public_key_openssh
  provisioner "local-exec" { # Create "tf-demo.pem" to your computer!!
    command = "echo '${tls_private_key.ppk.private_key_pem}' > /etc/ansible/roles/tf-demo.pem"
  }
  provisioner "local-exec" { # chmod 400
    command = "chmod 400 /etc/ansible/roles/tf-demo.pem"
  }
}

resource "aws_instance" "inst1" {
  ami             = var.ami
  instance_type   = var.inst_type
  subnet_id       = var.vpc_id_1
  key_name        = aws_key_pair.generated_key.key_name
  security_groups = [var.SG]
  tags = {
    Name = "inst1-sub1"
  }
}
resource "aws_instance" "inst2" {
  ami             = var.ami
  instance_type   = var.inst_type
  key_name        = aws_key_pair.generated_key.key_name
  subnet_id       = var.vpc_id_2
  security_groups = [var.SG]
  tags = {
    Name = "inst2-sub2"
  }
}
resource "null_resource" "web-config"{
provisioner "remote-exec"{
       inline=["echo 'Wait Untill SSH is ready'"]
       connection{
               type="ssh"
               user="ec2-user"
               private_key= file(var.path)
               host="${aws_instance.inst1.public_ip}"
               port= 22
       }
}
provisioner "local-exec" {
    command= "ansible-playbook /root/aws-tf/config_web/setup.yml"
  }
 depends_on=[aws_instance.inst1]
}
