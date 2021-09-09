
resource "aws_iam_role" "ec2-node" {
  name = "${var.env}-ec2-Worker-NodeInstanceProfile"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_instance_profile" "ec2-node" {
  name = "${var.env}-ECS-MS"
  role = "${aws_iam_role.ec2-node.name}"
}
