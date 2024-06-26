# EC2 frontend sg
resource "aws_security_group" "frontend-sg" {
    name        = "frontend-sg"
    description = "Frontend security group allow HTTP and SSH"
    vpc_id      = aws_vpc.lab-vpc.id

    ## Inbound
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ## Outbound
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "frontend-sg"
    }
}

# EC2 backend sg
resource "aws_security_group" "backend-sg" {
    name        = "backend-sg"
    description = "Backend security group allow HTTP and SSH"
    vpc_id      = aws_vpc.lab-vpc.id

    ## Inbound
    ingress {
        from_port   = 8090
        to_port     = 8090
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "ICMP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ## Outbound
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "backend-sg"
    }
}

# rds sg
resource "aws_security_group" "rds-sg" {
    name        = "rds-sg"
    description = "Database security group"
    vpc_id      = aws_vpc.lab-vpc.id

    ## Outbound
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "rds-sg"
    }
}

# Update backend-sg ingress to allow access from rds-sg
resource "aws_security_group_rule" "backend-to-rds" {
    type                        = "ingress"
    from_port                   = 5432
    to_port                     = 5432
    protocol                    = "TCP"
    security_group_id           = aws_security_group.backend-sg.id
    source_security_group_id    = aws_security_group.rds-sg.id
}

# Update backend-sg ingress to allow access from bastion-sg
resource "aws_security_group_rule" "backend-to-frontend" {
    type                        = "ingress"
    from_port                   = 22
    to_port                     = 22
    protocol                    = "TCP"
    security_group_id           = aws_security_group.backend-sg.id
    source_security_group_id    = aws_security_group.frontend-sg.id
}

# Update rds-sg ingress to allow access from backend-sg
resource "aws_security_group_rule" "rds_to_backend" {
    type                        = "ingress"
    from_port                   = 5432
    to_port                     = 5432
    protocol                    = "TCP"
    security_group_id           = aws_security_group.rds-sg.id
    source_security_group_id    = aws_security_group.backend-sg.id
}


