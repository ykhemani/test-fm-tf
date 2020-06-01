provider aws {
  region                 = var.aws_region
  profile                = var.aws_profile # alternatively, set AWS_PROFILE environment variable.
  assume_role {
    role_arn             = var.aws_auth_assume_role_arn
  }
}

data aws_iam_role my-role {
  name                   = var.instance_role
}

data aws_security_group existing {
  name                   = var.existing_security_group_name
}

resource aws_security_group allow_net_ports {
  name                   = "allow_net_ports"
  description            = "Allow inbound traffic"
  vpc_id                 = var.vpc_id

  ingress {
    description          = "Allow http to port 8080 from _____"
    from_port            = 8080
    to_port              = 8080
    protocol             = "tcp"
    cidr_blocks          = ["10.128.0.0/16", "10.28.0.0/16"]
  }

  ingress {
    description          = "Allow ssh from _____"
    from_port            = 22
    to_port              = 22
    protocol             = "tcp"
    cidr_blocks          = ["10.128.0.0/16", "10.28.0.0/16"]
  }

  tags = {
    Name                 = var.allow_net_ports_security_group_name
  }
}

resource aws_iam_instance_profile my-profile {
  name                   = var.instance_name
  role                   = data.aws_iam_role.my-role.id
}

################################################################################
# let's find the latest image for this owner
data aws_ami ami {
  most_recent            = true

  filter {
    name = "name"
    values = ["hashistack-encrypted-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "tag:Owner"
    values = [var.tag_owner]
  }

  owners = ["self"]
}

# use the ami_id if it isn't an empty string. otherwise, use the hashistack image.
locals {
  ami_id = var.ami_id == "" ? data.aws_ami.ami.id : var.ami_id
}

resource aws_instance ec2_instance {
  ami                    = var.ami_id
  instance_type          = var.instance_size
  key_name               = var.ssh_key
  iam_instance_profile   = aws_iam_instance_profile.my-profile.id
  subnet_id              = var.subnet_id

  root_block_device {
    volume_type          = var.root_volume_type
    encrypted            = var.root_volume_encrypt
    volume_size          = var.root_volume_size
    kms_key_id           = var.kms_key_id
  }

  security_groups        = [ data.aws_security_group.existing.id, aws_security_group.allow_net_ports.id ]

  user_data              = file(var.user_data_file)

  tags = {
    Name                 = var.instance_name
    Owner                = var.tag_owner
    fm_aws_applicationId = var.tag_appid
    fm_aws_businessUnit  = var.tag_bu
    fm_aws_dCatalogue    = var.tag_dcid
  }
}
