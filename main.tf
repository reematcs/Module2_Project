terraform{
required_version = ">= 1.0" # semver 
      required_providers {
        aws = {
          source = "hashicorp/aws"
          version = "4.55.0"
        }
      }
}
locals {
  ami_id = "${var.ami_id}"
  vpc_id = "${var.vpc_id}"
  ssh_user = "ubuntu"
  key_name = "${var.aws_terraform_keyname}"
  private_key_path = "${var.aws_terraform_keyname}.pem"
}

resource "aws_security_group" "deployment_sec_group" {
	name   = "deployment_sec_group"
	vpc_id = local.vpc_id

  ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  ingress {
		from_port   = 8080
		to_port     = 8080
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}  
  egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
resource "aws_security_group" "server_sec_group" {
	name   = "server_sec_group"
	vpc_id = local.vpc_id

  ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  ingress {
		from_port   = 8080
		to_port     = 8080
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
#Create an IAM Policy
resource "aws_iam_policy" "access-s3-policy" {
  name        = "S3accesspolicy"
  description = "Provides permission to access S3"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role" "access_bucket_role" {
  name = "bucket_access_role"

  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
})

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy_attachment" "bucket-role-attach" {
  name       = "role-attachment"
  roles      = [aws_iam_role.access_bucket_role.name]
  policy_arn = aws_iam_policy.access-s3-policy.arn
}
resource "aws_iam_instance_profile" "access-s3-profile" {
  name = "s3-access-profile"
  role = aws_iam_role.access_bucket_role.name
}
resource "aws_instance" "ansible_provisioning_server" {
  ami = local.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  vpc_security_group_ids =[aws_security_group.server_sec_group.id]
  key_name = local.key_name
  iam_instance_profile = aws_iam_instance_profile.access-s3-profile.name

  tags = {
    Name = "Ansible_Provisioning_Server"
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = local.ssh_user
    private_key = file(local.private_key_path)
    timeout = "4m"
  }
  user_data = <<EOF
#!/bin/bash
sudo apt-add-repository -y ppa:ansible/ansible
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install unzip -y
sudo apt install ansible -y
sudo apt install openjdk-11-jdk -y
sudo apt install maven -y
sudo apt install awscli -y
sudo apt install git -y
sudo apt install jenkins -y
sudo systemctl start jenkins.service 
EOF

# TODO: Try using aws user data to run at boot time
# TODO: Have the content on a script

}

resource "aws_instance" "ansible_deployment" {
  ami = local.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  vpc_security_group_ids =[aws_security_group.deployment_sec_group.id]
  key_name = local.key_name
  iam_instance_profile = aws_iam_instance_profile.access-s3-profile.name

  tags = {
    Name = "Ansible_Provisioning_deployment"
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = local.ssh_user
    private_key = file(local.private_key_path)
    timeout = "4m"
  }
   user_data = <<EOF
#!/bin/bash
sudo apt update
sudo apt install acl -y
sudo apt install awscli -y
EOF
}

data "archive_file" "data_backup" {
  type        = "zip"
  source_dir = "./ansible_provisioning"
  output_path = "${var.ansible_zip}"
  depends_on = [
    local_file.tf_ansible_inventory
 ]
 
}
# }
# Upload an object
resource "aws_s3_object" "upload_ansible" {
#    count = data.aws_s3_bucket.b1.id ? 1 : 0
    # bucket_id_ref = data.aws_s3_bucket.b1.id
    bucket = aws_s3_bucket.b1.id
    key = "${var.ansible_zip}"
    source = "${var.ansible_zip}"
    #etag = filemd5("${var.ansible_zip}")
depends_on = [
    data.archive_file.data_backup
 ]
}

resource "null_resource" "InitialSetup" {
 
  connection {
    type = "ssh"
    host = aws_instance.ansible_provisioning_server.public_ip
    user = local.ssh_user
    private_key = file(local.private_key_path)
    timeout = "4m"
  }

  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1",
      "cat ~/.ssh/id_rsa.pub",
      "while ! which unzip; do sleep 10; echo \"Sleeping for a bit to make sure unzip is installed.\"; done",
      "while ! which aws; do sleep 10; echo \"Sleeping for a bit to make sure awscli is installed.\"; done",
      "sudo aws s3 cp /home/ubuntu/.ssh/id_rsa.pub s3://${aws_s3_bucket.b1.id}/id_rsa.pub",
      "sudo aws s3 cp s3://${aws_s3_bucket.b1.id}/ansible.zip .",
      "unzip ansible.zip",
      #"ansible-playbook -i ./inventory tomcat.yml"
    ]
  }
  depends_on = [
    aws_s3_object.upload_ansible
  ]
}


resource "null_resource" "CopyPubTodeployment" {
 
  connection {
    type = "ssh"
    host = aws_instance.ansible_deployment.public_ip
    user = local.ssh_user
    private_key = file(local.private_key_path)
    timeout = "4m"
  }

  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "while ! which aws; do sleep 10; echo \"Sleeping for a bit...\"; done",
      "sudo aws s3 cp s3://${aws_s3_bucket.b1.id}/id_rsa.pub .",
      "cat id_rsa.pub >> ~/.ssh/authorized_keys",
      #"ansible-playbook -i ./inventory tomcat.yml"
    ]
  }
  depends_on = [
    null_resource.InitialSetup
  ]
}


resource "null_resource" "FinalSetup" {
 
  connection {
    type = "ssh"
    host = aws_instance.ansible_provisioning_server.public_ip
    user = local.ssh_user
    private_key = file(local.private_key_path)
    timeout = "4m"
  }

  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "ansible-playbook -i ./inventory tomcat_playbook.yml",
      "ansible-playbook -i inventory deploy_war.yml",
      "echo \"URL: http://${aws_instance.ansible_deployment.public_ip}:8080/sparkjava-hello-world-1.0/hello\"",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    ]
  }
  depends_on = [
    null_resource.CopyPubTodeployment
  ]
}
