resource "aws_lb" "frontend-alb" {
  name               = "frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.frontend-sg.id]
  subnets            = [aws_subnet.public-subnet-1.id]

  enable_deletion_protection = true

  tags = {
    Environment = "dev/test"
  }
}

resource "aws_alb_target_group" "frontend-tg" {
  name     = "frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.lab-vpc.id
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