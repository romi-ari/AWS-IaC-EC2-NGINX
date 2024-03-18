resource "aws_db_subnet_group" "private-subnet-group" {
    name        = "main"
    subnet_ids  = flatten([aws_subnet.private-subnet-2.id, aws_subnet.private-subnet-3.id])

    tags = {
        Name = "private-subnet-group"
    }
}

resource "aws_db_instance" "dbpostgres" {
    allocated_storage       = 80
    storage_type            = "gp3"
    db_name                 = "todoapp"
    engine                  = "postgres"
    engine_version          = "16.1"
    instance_class          = "db.t3.micro"
    username                = "postgress"
    password                = "postgress"
    publicly_accessible     = false
    skip_final_snapshot     = true
    db_subnet_group_name    = aws_db_subnet_group.private-subnet-group.name
    vpc_security_group_ids  = [aws_security_group.rds-sg.id]
}