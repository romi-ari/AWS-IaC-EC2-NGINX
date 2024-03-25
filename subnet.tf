# Public Subnet 1
resource "aws_subnet" "public-subnet-1" {
    vpc_id              = aws_vpc.lab-vpc.id
    cidr_block          = "10.0.1.0/24"
    availability_zone   = var.az-1a

    tags = {
        Name = "public-subnet-1"
    }
}

# Private Subnet 1
resource "aws_subnet" "private-subnet-1" {
    vpc_id              = aws_vpc.lab-vpc.id
    cidr_block          = "10.0.6.0/24"
    availability_zone   = var.az-1a

    tags = {
        Name = "private-subnet-1"
    }
}

# Private Subnet 2
resource "aws_subnet" "private-subnet-2" {
    vpc_id              = aws_vpc.lab-vpc.id
    cidr_block          = "10.0.7.0/24"
    availability_zone   = var.az-1b

    tags = {
        Name = "private-subnet-2"
    }
}



