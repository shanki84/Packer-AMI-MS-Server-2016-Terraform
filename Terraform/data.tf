#-- Grab the latest AMI built with packer - widows2016.json
data "aws_ami" "Windows_2016" {
  filter {
    name   = "is-public"
    values = ["false"]
  }

  filter {
    name   = "name"
    values = ["windows2016Server*"]
  }

  most_recent = true
}

#-- sets the user data script
data "template_file" "user_data" {
  template = "/scripts/user_data.ps1"
}