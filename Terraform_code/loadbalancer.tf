resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 3000 
  protocol = "HTTP"
  vpc_id   = module.network.vpc.id

  health_check {
    path                = "/"
    port                = 3000
    protocol            = "HTTP"
    timeout             = 5
    interval            = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.common_resource_name}_Target_Group"
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.private_instance.id
  port             = 3000
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

resource "aws_lb" "my_load_balancer" {
  name               = "my-alb"
  internal           = false 
  load_balancer_type = "application"

  subnets            = [
    module.network.subnets["public1"].id,
    module.network.subnets["public2"].id
  ] 
  tags = {
    Name = "${var.common_resource_name}_ALB"
  }
}
