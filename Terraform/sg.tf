resource "aws_security_group" "demo-node" {
  name        = "${var.env}-ec2"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${aws_vpc.demo.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "${var.env}-ec2",
    )
  }"
}

resource "aws_security_group_rule" "ec2-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.ec2-node.id}"
  source_security_group_id = "${aws_security_group.ec2-node.id}"
  to_port                  = 65535
  type                     = "ingress"
}