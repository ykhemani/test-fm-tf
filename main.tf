provider "aws" {
  region  = "us-east-1"
  profile = "profile_name"
  assume_role {
    role_arn = "arn:aws:iam::00000000:role/role_name"
  }
}


data "aws_iam_role" "my-role" {
  name = "role_to_assume"
}


variable "subnet_prv1" {
  description = "Private Subnet 1"
  default = "subnet-xxxxxxxxxxxxxxxxx"
}


resource "aws_security_group" "allow_net_ports" {
  name        = "allow_net_ports"
  description = "Allow inbound traffic"
  vpc_id      = "vpc-id-to-use"

  ingress {
    description = "Web Node"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.128.0.0/16", "10.28.0.0/16"]
  }

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.128.0.0/16", "10.28.0.0/16"]
  }


  tags = {
    Name = "allow_sg_rules"
  }

}


resource "aws_iam_instance_profile" "my-profile" {
  name = var.instance_name
  role = data.aws_iam_role.my-role.id
}

resource "aws_instance" "ec2_instance" {
  ami         = "ami-xxxxxxxxxxxxx"
  instance_type = "t2.medium"
  key_name = "ssh_key"
  iam_instance_profile = aws_iam_instance_profile.my-profile.id
  subnet_id = var.subnet_prv1
  
  root_block_device {
    volume_type = "gp2"
    encrypted = true
    volume_size = 150
    kms_key_id = "arn:aws:kms:us-east-1:000000000:key/key-id"
  }

  security_groups = [ "sg-existing-id", aws_security_group.allow_net_ports.id ]
 
  user_data = file("install_app.sh")

  tags = {
  Name = var.instance_name
  Owner = "prash@email.com"
  fm_aws_applicationId = "appid"
  fm_aws_businessUnit = "it"
  fm_aws_dCatalogue = "datacatolog-id"
  }

}

