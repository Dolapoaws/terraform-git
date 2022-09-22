locals {
  common_tags = {
    Name = "jjtech"
    App_Name = "ovid"
    Cost_center = "xyz222"
    Business_unit = "GBS"
    Project = "GBS"
    App_role = "web server"
    Customer = "Students"
    Environment = "dev"
    Confidentiality = "Restricted"
    Owner = "jespo_mbwoge@jjtechinc.co"
    Opt_in-Opt_out = "yes"
    Application_ID = "197702"
    Compliance = "pci"
  }
}

resource "aws_instance" "JJtechWeb" {
  ami = var.ami["linux"]
  instance_type = var.instance_type[0]
  tags = local.common_tags
}

resource "aws_instance" "JJtechWeb01" {
  ami = var.ami["linux"]
  instance_type = var.instance_type[1]
  tags = local.common_tags
}

resource "aws_instance" "JJtechWeb02" {
  ami = var.ami["linux"]
  instance_type = var.instance_type[2]
  tags = local.common_tags
}

resource "aws_ebs_volume" "JJtechEBS1" {
  availability_zone = "us-west-2a"
  size              = 40

  tags = local.common_tags
}

output "JJtechEC2" {
  value = aws_instance.JJtechWeb.public_ip
}


/*
resource "aws_volume_attachment" "jjtechEBSAttachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.web.id
}

resource "aws_instance" "web" {
  ami               = "ami-21f78e11"
  availability_zone = "us-west-2a"
  instance_type     = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_ebs_volume" "example" {
  availability_zone = "us-west-2a"
  size              = 1
}
*/

resource "aws_eip" "JJtechEIP" {
  vpc = true
}

output "JJtecheip" {
  value = aws_eip.JJtechEIP.id
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.JJtechWeb.id
  allocation_id = aws_eip.JJtechEIP.id
}

/*
resource "aws_security_group" "jjtechsg" {
  name        = "jjtechsg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    description      = "ALlow HTTP Only from the EIP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.default.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  */
