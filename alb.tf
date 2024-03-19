# Frontend ALB
resource "aws_lb" "frontend-alb" {
  name               = "frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.frontend-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "dev/test"
  }
}

resource "aws_alb_target_group" "frontend-tg" {
  name     = "frontend-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.lab-vpc.id

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    interval            = 10

  }
}

resource "aws_lb_target_group_attachment" "attach-frontend-tg" {
  target_group_arn = aws_alb_target_group.frontend-tg.arn
  target_id        = aws_instance.frontend-app.id
  port             = 3000
}

resource "aws_lb_listener" "frontend-listener" {
  port              = 80
  load_balancer_arn = aws_lb.frontend-alb.arn
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.frontend-tg.arn
    type             = "forward"
  }
}

resource "aws_lb" "backend-alb" {
  name               = "backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.backend-sg.id]
  subnets            = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-3.id]

  enable_deletion_protection = false

  tags = {
    Environment = "dev/test"
  }
}

resource "aws_alb_target_group" "backend-tg" {
  name     = "backend-tg"
  port     = 8090
  protocol = "HTTP"
  vpc_id   = aws_vpc.lab-vpc.id

  health_check {
    path                = "/api/todos"
    healthy_threshold   = 5
    unhealthy_threshold = 5
    interval            = 10
    
  }
}

resource "aws_lb_target_group_attachment" "attach-backend-tg" {
  target_group_arn = aws_alb_target_group.backend-tg.arn
  target_id        = aws_instance.backend-app.id
  port             = 8090
}

resource "aws_lb_listener" "backend-listener" {
  port              = 80
  load_balancer_arn = aws_lb.backend-alb.arn
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.backend-tg.arn
    type             = "forward"
  }
}