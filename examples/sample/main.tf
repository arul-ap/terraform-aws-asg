terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = var.default_tags
  }
}


module "asg" {
  source = "arul-ap/asg/aws"
  org    = "abc"
  proj   = "proj-x"
  env    = "dev"
  lt = {
    name          = "lt-01"
    ami_id        = "ami-0910e4162f162c238"
    instance_type = "t2.micro"
  }
  asg = {
    name         = "asg-01"
    subnet_id    = [module.vpc.public_subnet_id["web-subnet-01"], module.vpc.public_subnet_id["web-subnet-02"], module.vpc.public_subnet_id["web-subnet-03"]]
    lb_tg_arn    = module.alb_public_http.tg_arn["tg-03"]
    min_size     = 1
    max_size     = 1
    desired_size = 1
  }
}
