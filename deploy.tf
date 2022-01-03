# Root Module
provider "aws" {
  profile = var.profile
  region  = var.region
}
module "vpc" {
  source = "./vpc-mod"

}
module "SG" {
  source = "./sg-mod"
  vpc_id = module.vpc.vpc_id
}
module "instance" {
  source = "./ec2-mod"
  # Reference from VPC output vars
  vpc_id_1 = module.vpc.subnet_id1
  vpc_id_2 = module.vpc.subnet_id2
  SG       = module.SG.SG_VPC
}
#
#module "config" {
#	source="./config_web"
#	public_ip=module.instance.host
#
#}
#
