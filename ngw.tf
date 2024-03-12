resource "aws_eip" "lab-eip" {
    domain = "vpc"

    tags = {
        Name = "ngw-eip-1"
    }
}

resource "aws_nat_gateway" "lab-ngw" {
    allocation_id = aws_eip.lab-eip.id
    subnet_id     = aws_subnet.public-subnet-1.id

    tags = {
        Name = "lab-ngw"
    }

    depends_on = [aws_internet_gateway.lab-igw]
} 