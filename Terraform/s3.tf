  #--- Copy ssh keys to S3 Bucket
  provisioner "local-exec" {
    command = "aws s3 cp ${path.module}/secret s3://PATHTOKEYPAIR/ --recursive"
  }

  #--- Copy reporting applications from S3 bucket to destication dir
  provisioner "local-exec" {
      command = "aws s3 cp s3://myBucket/dir destination_dir --recursive"
  }


  #--- Deletes keys on destroy
  provisioner "local-exec" {
    when    = "destroy"
    command = "aws s3 rm 3://PATHTOKEYPAIR/${module.ssh_key_pair.key_name}.pem"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "aws s3 rm s3://PATHTOKEYPAIR/${module.ssh_key_pair.key_name}.pub"
  }
}