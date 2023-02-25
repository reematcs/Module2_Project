output "ip_worker" {
  value = aws_instance.ansible_worker.private_ip
}
output "ip_server" {
  value = aws_instance.ansible_provisioning_server.private_ip
}
# Export Terraform variable values to an Ansible var_file
resource "local_file" "tf_ansible_inventory" {
  content = <<-DOC
    # Ansible vars_file containing variable values from Terraform.
    # Generated by Terraform mgmt configuration.

    [webservers]
    ${aws_instance.ansible_worker.public_ip}

    
    [webservers:vars]
    ansible_ssh_common_args="-o StrictHostKeyChecking=no"
    DOC
  filename = "./ansible_provisioning/inventory"
  
  provisioner "local-exec" {
    when    = destroy
    command = "rm ansible.zip"
 }
}

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.b1.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "s3:*" ],
      "Resource": [
        "${aws_s3_bucket.b1.arn}",
        "${aws_s3_bucket.b1.arn}/*"
      ]
    }
  ]
}
EOF
}