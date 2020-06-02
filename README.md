# test-fm-tf

This repository contains sample code for provisioning to [AWS](https://aws.amazon.com/) using [Terraform](https://terraform.io).

## Input values
* `aws_profile` - AWS Profile for authenticating with AWS Provider.
* `aws_auth_assume_role_arn` - AWS Role ARN for role to assume.
* `vpc_id` - value for existing VPC ID in which to provision resources.
* `subnet_id` - value for existing Subnet ID in which to provision resources.
* `existing_security_group_name` - name of existing security group to apply to aws_instance that we will provision.
* `allow_net_ports_security_group_name` - name of net_ports security group that will be created.
* `instance_role` - name of AWS role for instance.
* `kms_key_id` - existing KMS Key ID for encrypting root volume.
* `instance_name` - value for aws_instance name tag.
* `ssh_key` - SSH key name for logging into instance.
* `tag_owner` - value for owner tag.
* `tag_appid` - value for fm_aws_applicationId tag.
* `tag_bu` - value for fm_aws_businessUnit tag.
* `tag_dc_id` - value for fm_aws_dCatalogue tag.

## Output values
* `instance_ip` - private IP for aws_instance that will be created.
