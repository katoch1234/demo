######################################################################################
#  VPC & SUBNETS
######################################################################################

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "Bastion-VPC"
    Environment = "${var.Environment}"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "Public-subnet1" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block = var.PublicSubnetsCidr[0]
  map_public_ip_on_launch = true

    tags = {
    Name = "Public-Subnet-1"
    Environment = "${var.Environment}-public-subnet(AZ-1)"

  }
}

resource "aws_subnet" "Public-subnet2" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  cidr_block = var.PublicSubnetsCidr[1]
  map_public_ip_on_launch = true

    tags = {
    Name = "Public-Subnet-2"
    Environment = "${var.Environment}-public-subnet-(AZ2)"

  }
}


resource "aws_subnet" "private-subnet1" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block = var.PrivateSubnetsCidr[0]
  map_public_ip_on_launch = false

    tags = {
    Name = "Private-Subnet-1"
    Environment = "${var.Environment}-Private-Subnet-(AZ1)"

  }
}

resource "aws_subnet" "private-subnet2" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  cidr_block = var.PrivateSubnetsCidr[1]
  map_public_ip_on_launch = false

    tags = {
    Name = "Private-subnet-2"
    Environment = "${var.Environment}-Private-subnet-(AZ2)"

  }
}

###################################################################################################
#  Internet Gateway
###################################################################################################

resource "aws_internet_gateway" "Igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Bastion-Host-IG"
    Environment = "${var.Environment}"
  }
}

###############################################################################################
# Route Tables 
###############################################################################################

resource "aws_route_table" "PublicRT1" {
  vpc_id = aws_vpc.main.id

  route {
    gateway_id = aws_internet_gateway.Igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Environment = "${var.Environment}"
  }
}

resource "aws_route_table" "PrivateRT1" {
  vpc_id = aws_vpc.main.id
  route {
    gateway_id = aws_nat_gateway.NatGateway1.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Environment = "${var.Environment}"
  }
}

resource "aws_route_table" "PrivateRT2" {
  vpc_id = aws_vpc.main.id
  route {
    gateway_id = aws_nat_gateway.NatGateway1.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Environment = "${var.Environment}"
  }
}

###################################################################################################
# Route Table Assosiation
###################################################################################################

resource "aws_route_table_association" "PublicSubnet1RTAssociation" {
  subnet_id      = aws_subnet.Public-subnet1.id
  route_table_id = aws_route_table.PublicRT1.id
}

resource "aws_route_table_association" "PublicSubnet2RTAssociation" {
  subnet_id      = aws_subnet.Public-subnet2.id
  route_table_id = aws_route_table.PublicRT1.id
}


resource "aws_route_table_association" "PrivateSubnet1RTAssociation" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.PrivateRT1.id
}

resource "aws_route_table_association" "PrivateSubnet2RTAssociation" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.PrivateRT2.id
}

###################################################################################################
# Elastic IP & NAT Gateway
###################################################################################################

resource "aws_eip" "NatGatewayEIP1" {
  vpc   = true
}

resource "aws_nat_gateway" "NatGateway1" {
  depends_on = [aws_eip.NatGatewayEIP1]
  allocation_id = aws_eip.NatGatewayEIP1.id
  subnet_id     = aws_subnet.Public-subnet1.id

  tags = {
    Name = "Bastion-NAT"
    Environment = "${var.Environment}"
  }
}

###################################################################################################
# Security Groups nfgroup-web-staging-sg
##################################################################################################

resource "aws_security_group" "STAGING_EC2_Instance-nfgroup-web-staging" {
  name        = "nfgroup-web-staging-sg"
  description = "STAGING EC2 Instance - nfgroup-web-staging - Security Group exclusively for this specific instance"
  vpc_id      = aws_vpc.main.id
  ingress {
    description      = "NOW Finance Office"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["202.148.225.18/32"]
  }
  ingress {
    description      = "timg-20201211-1121"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["122.110.108.173/32"]
  }
   ingress {
    description      = "NOW Finance Office - New"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["210.56.236.162/32"]
  }
  ingress {
    #description      = "NOW Finance Office - New"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["64.41.200.96/28"]
  }
   ingress {
    description      = "IBSA Office - TPG"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["220.244.63.162/32"]
  }
    ingress {
    description      = "James Home"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["58.84.184.110/32"]
  }
    ingress {
    description      = "IBSA Office VPN - VOCUS"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = ["49.255.202.34/32"]
  }
   ingress {
    #description      = "IBSA Office VPN - VOCUS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["64.41.200.96/28"]
  }
  

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
  tags = {
    Environment = "${var.Environment}"
  }
}

#####################################################################################################
# ALB - security group
####################################################################################################

resource "aws_security_group" "ALB-SG" {
  name        = "ALB-security-group"
  description = "ALB-security-group"
  vpc_id      = aws_vpc.main.id
    ingress {
    description      = "allow http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
    description      = "allow https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  }

  ####################################################################################################
  # Bastion server - Security group
  ####################################################################################################

  resource "aws_security_group" "Bastion-ec2-SG" {
  name        = "Bastion-SG"
  description = "bastion-host-security-group"
  vpc_id      = aws_vpc.main.id
    ingress {
    description      = "allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

#######################################################################################################
# Private EC2 Security group
#######################################################################################################

resource "aws_security_group" "Private-ec2-SG" {
  name        = "bastion-security-group"
  description = "bastion-host-security-group"
  vpc_id      = aws_vpc.main.id
    ingress {
    description      = "allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = [aws_security_group.Bastion-ec2-SG.id]
    }

    ingress {
    description      = "allow Http from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.ALB-SG.id]
    }

    ingress {
    description      = "allow Https from ALB"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups = [aws_security_group.ALB-SG.id]
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

####################################################################################################
#  AWS Load Balancer
####################################################################################################

resource "aws_lb" "bastion-alb" {
  name               = "bastion-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB-SG.id]
  subnets            = [aws_subnet.Public-subnet1.id,aws_subnet.Public-subnet2.id]

  enable_deletion_protection = false

  tags = {
    Name = "Bastion-ALB"
    Environment = "staging"
  }
}

###################################################################################################
# Target Groups 
###################################################################################################

resource "aws_lb_target_group" "bastion-tg" {
  name     = "bastion-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

#################################################################################################
#   ALB Listeners
#################################################################################################

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.bastion-alb.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bastion-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.bastion-tg.arn
  target_id        = aws_instance.new-instance.id
  port             = 80
}


##################################################################################################
# AWS AMI from instance 
#################################################################################################

resource "aws_ami_from_instance" "ec2" {
  name               = "ami-from-instance"
  source_instance_id = "${var.ami_image}"
}

#####################################################################################################
# Creation of EC2 instance from the AMI
#####################################################################################################

resource "aws_instance" "new-instance" {
  ami           = aws_ami_from_instance.ec2.id
  instance_type = "t2.micro"
  key_name = "komal"
  subnet_id = aws_subnet.private-subnet1.id
  vpc_security_group_ids = [aws_security_group.STAGING_EC2_Instance-nfgroup-web-staging.id,aws_security_group.Private-ec2-SG.id]
  tags = {
    Environment = "${var.Environment}"
    Name = "ec2-from-ami"
  }
  }

#####################################################################################################
# Bastion Server
#####################################################################################################

resource "aws_instance" "bastion-instance" {
  ami           = "ami-09a5c873bc79530d9"
  instance_type = "t2.micro"
  key_name = "komal"
  subnet_id = aws_subnet.Public-subnet1.id
  vpc_security_group_ids = [aws_security_group.Bastion-ec2-SG.id]
  tags = {
    Environment = "${var.Environment}"
    Name = "Bastion-host"
  }
}








