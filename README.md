# demo
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ami_from_instance.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_from_instance) | resource |
| [aws_eip.NatGatewayEIP1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.bastion-instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.new-instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.Igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_lb.bastion-alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.bastion-tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_nat_gateway.NatGateway1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.PrivateRT1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.PrivateRT2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.PublicRT1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.PrivateSubnet1RTAssociation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.PrivateSubnet2RTAssociation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.PublicSubnet1RTAssociation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.PublicSubnet2RTAssociation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.ALB-SG](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.Bastion-ec2-SG](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.Private-ec2-SG](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.STAGING_EC2_Instance-nfgroup-web-staging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.Public-subnet1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.Public-subnet2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private-subnet1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private-subnet2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Environment"></a> [Environment](#input\_Environment) | n/a | `string` | `"Staging"` | no |
| <a name="input_PrivateSubnetsCidr"></a> [PrivateSubnetsCidr](#input\_PrivateSubnetsCidr) | n/a | `list(string)` | <pre>[<br>  "10.0.128.0/19",<br>  "10.0.160.0/19"<br>]</pre> | no |
| <a name="input_PublicSubnetsCidr"></a> [PublicSubnetsCidr](#input\_PublicSubnetsCidr) | n/a | `list(string)` | <pre>[<br>  "10.0.0.0/19",<br>  "10.0.32.0/19"<br>]</pre> | no |
| <a name="input_ami_image"></a> [ami\_image](#input\_ami\_image) | n/a | `string` | `"i-007c12c0bb2bd04c0"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ALB_DNS"></a> [ALB\_DNS](#output\_ALB\_DNS) | n/a |
| <a name="output_PrivateSubnet1Ids"></a> [PrivateSubnet1Ids](#output\_PrivateSubnet1Ids) | n/a |
| <a name="output_PrivateSubnet2Ids"></a> [PrivateSubnet2Ids](#output\_PrivateSubnet2Ids) | n/a |
| <a name="output_PrivateSubnetsIds"></a> [PrivateSubnetsIds](#output\_PrivateSubnetsIds) | a list of private-subnets |
| <a name="output_PublicSubnet1Ids"></a> [PublicSubnet1Ids](#output\_PublicSubnet1Ids) | n/a |
| <a name="output_PublicSubnet2Ids"></a> [PublicSubnet2Ids](#output\_PublicSubnet2Ids) | n/a |
| <a name="output_PublicSubnetsIds"></a> [PublicSubnetsIds](#output\_PublicSubnetsIds) | a list of public-subnets |
| <a name="output_VpcId"></a> [VpcId](#output\_VpcId) | n/a |
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | n/a |
<!-- END_TF_DOCS -->