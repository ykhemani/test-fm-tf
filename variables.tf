variable aws_region {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

variable aws_profile {
  type        = string
  description = "AWS profile."
}

variable aws_auth_assume_role_arn {
  type        = string
  description = "Role ARN for role to assume."
}

variable vpc_id {
  type        = string
  description = "VPC ID"
}

variable subnet_id {
  type        = string
  description = "Subnet ID for private subnet 1"
}

variable existing_security_group_name {
  type        = string
  description = "Name of existing security group to apply to instance"
}

variable allow_net_ports_security_group_name {
  type        = string
  description = "Name of allow net ports security group to create"
}

variable instance_role {
  type        = string
  description = "Name of AWS role for instance."
}

variable ami_id {
  type        = string
  description = "AMI to use for instance"
  default     = ""
}

variable ami_filter {
  type        = string
  description = "Use existing AMI with this name filter"
  default     = "hashistack-encrypted-*"
}


variable instance_size {
  type        = string
  description = "VPC ID"
  default     = "t2.medium"
}

variable user_data_file {
  type        = string
  description = "Name of script to use for user data"
  default     = "install_app.sh"
}

variable kms_key_id {
  type        = string
  description = "Existing KMS Key ID for encrypting root volume."
  # default   = "arn:aws:kms:us-east-1:000000000:key/key-id"
}

variable root_volume_type {
  type        = string
  description = "Root volume type."
  default     = "gp2"
}

variable root_volume_encrypt {
  type        = bool
  description = "Encrypt root volume?"
  default     = true
}

variable root_volume_size {
  type        = number
  description = "Root volume size in GB."
  default     = 150
}

variable instance_name {
  type        = string
  description = "Value for instance Name tag."
}

variable ssh_key {
  type        = string
  description = "SSH key name for logging into instance."
}

variable tag_owner {
  type        = string
  description = "Value for Owner tag"
  #default    = "prash@email.com"
}

variable tag_appid {
  type        = string
  description = "Value for fm_aws_applicationId tag"
  #default    = "appid"
}

variable tag_bu {
  type        = string
  description = "Value for fm_aws_businessUnit tag"
  default     = "it"
}

variable tag_dcid {
  type        = string
  description = "Value for fm_aws_dCatalogue tag"
  #default    = "datacatolog-id"
}
