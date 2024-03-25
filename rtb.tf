# Route table for public subnet 1
resource "aws_route_table" "rtb-public" {
    vpc_id = aws_vpc.lab-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.lab-igw.id
    }

    tags = {
        Name = "rtb-public"
    }
}

# Route table for private subnet 1
resource "aws_route_table" "rtb-private" {
    vpc_id = aws_vpc.lab-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.lab-ngw.id
    }

    tags = {
        Name = "rtb-private"
    }
}


# Route table association for public subnet 1
resource "aws_route_table_association" "rtb-public1-association" {
    route_table_id  = aws_route_table.rtb-public.id
    subnet_id       = aws_subnet.public-subnet-1.id
}

# Route table association for private subnet 1
resource "aws_route_table_association" "rtb-private-1-association" {
    route_table_id  = aws_route_table.rtb-private.id
    subnet_id       = aws_subnet.private-subnet-1.id
}

# Route table association for private subnet 1
resource "aws_route_table_association" "rtb-private-2-association" {
    route_table_id  = aws_route_table.rtb-private.id
    subnet_id       = aws_subnet.private-subnet-2.id
}
