resource "null_resource" "web-config"{
#provisioner "remote-exec"{
#	inline=["echo 'Wait Untill SSH is ready'"]
#	connection{
#        	type="ssh"
#        	user="ec2-user"
#        	private_key= file(var.path)
#        	host="${var.public_ip}"
#		port= 22
#	}
#}
provisioner "local-exec" {	
    command= "ansible-playbook setup.yml"
  }
}
