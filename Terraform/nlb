resource "aws_lb" "ec2_asg" {
name                        = "${var.env}-internal-facing-nlb"
internal                    = true
load_balancer_type          = "network"
subnet                      = ["${aws_subnet.public.*.id}"]
enable_deletion_protection  = true

tags = "${
  map(
    "Name", "${var.env}-internal-facing-nlb"
    "Role", "Network Load Balancer"
    )
  }"
}

resource "aws_lb_target_group" "ec2_tgt" {
  name        = "${var.env}-lb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.ec2.id
}

resource "aws_lb_listener" "ec2_listener" {
  load_balancer_arn = aws_lb.ec2_asg.id

  default_action {
    target_group_arn = aws_lb_target_group.ec2_tgt.id
    type             = "forward"
  }
}

resource "aws_vpc_endpoint_service" "ec2_asg" {
  acceptance_required        = false
  network_load_balancer_arns = [aws_lb.ec2_asg.arn]
}

resource "aws_vpc_endpoint_service" "ec2_asg" {
  acceptance_required        = false
  gateway_load_balancer_arns = [aws_lb.example.arn]
}