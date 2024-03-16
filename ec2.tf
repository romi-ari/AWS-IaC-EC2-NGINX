data "aws_ami" "instance" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Backend app
resource "aws_instance" "bastion-host" {
    ami                     = data.aws_ami.instance.id
    instance_type           = var.instance-type
    key_name                = "vockey"
    availability_zone       = var.az-1a
    vpc_security_group_ids  = [aws_security_group.bastion-sg.id]
    subnet_id               = aws_subnet.public-subnet-1.id
    
    root_block_device {
      volume_type           = "gp3"
      volume_size           = "8"
      delete_on_termination = true
    }

    tags = {
        Name =  "bastion-host"
    }
}

# Frontend app
resource "aws_instance" "frontend-app" {
    ami                     = data.aws_ami.instance.id
    instance_type           = var.instance-type
    key_name                = "vockey"
    availability_zone       = var.az-1a
    vpc_security_group_ids  = [aws_security_group.frontend-sg.id]
    subnet_id               = aws_subnet.public-subnet-1.id
    
    root_block_device {
      volume_type           = "gp3"
      volume_size           = "8"
      delete_on_termination = true
    }

    tags = {
        Name =  "frontend-app"
    }
}

# Backend app
resource "aws_instance" "backend-app" {
    ami                     = data.aws_ami.instance.id
    instance_type           = var.instance-type
    key_name                = "vockey"
    availability_zone       = var.az-1a
    vpc_security_group_ids  = [aws_security_group.backend-sg.id]
    subnet_id               = aws_subnet.private-subnet-1.id
    
    root_block_device {
      volume_type           = "gp3"
      volume_size           = "8"
      delete_on_termination = true
    }

    user_data = <<EOF
    
    EOF

    tags = {
        Name =  "backend-app"
    }
}