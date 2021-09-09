output "instance_id" {
  value = "${aws_instance.ec2}"
}

output "Public_DNS" {
  value = "${aws_instance.ec2.public_dns}"
}

output "Instance_Public_IP" {
  value = "${aws_instance.ec2.public_ip}"
}

output "Administrator_Password" {
  value = "${rsadecrypt(aws_instance.ec2.password_data, file("${module.ssh_key_pair.private_key_filename}"))}"
}

output "SSH_Key_Name" {
  value = "${module.ssh_key_pair.key_name}"
}

output "Key_Filename-Private" {
  value = "${module.ssh_key_pair.private_key_filename}"
}


output "Key_Filename-Public" {
  value = "${module.ssh_key_pair.public_key_filename}"
}
