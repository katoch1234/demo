output "VpcId" {
  value = join ("-",[aws_vpc.main.id,"VPC-ID"])
}

output "PublicSubnetsIds" {
    description = "a list of public-subnets"
  value = join (",", [aws_subnet.Public-subnet1.id,aws_subnet.Public-subnet2.id])
}

output "PrivateSubnetsIds" {
    description = "a list of private-subnets"
  value = join (",", [aws_subnet.private-subnet1.id,aws_subnet.private-subnet2.id])
}


output "PublicSubnet1Ids" {
  value = join ("-", [aws_subnet.Public-subnet1.id,"Public-Subnet1-ID"])
}

output "PrivateSubnet1Ids" {
  value = join ("-", [aws_subnet.private-subnet1.id,"Private-Subnet1-ID"])
}

output "PublicSubnet2Ids" {
  value = join ("-", [aws_subnet.Public-subnet2.id,"Public-Subnet2-ID"])
}

output "PrivateSubnet2Ids" {
  value = join ("-", [aws_subnet.private-subnet2.id,"Private-Subnet1-ID"])
}

output "security_group" {
    value = join ("-", [aws_security_group.STAGING_EC2_Instance-nfgroup-web-staging.id,"STAGING_EC2_Instance-nfgroup-web-staging"])
}

output "ALB_DNS" {
    value = aws_lb.bastion-alb.dns_name
}