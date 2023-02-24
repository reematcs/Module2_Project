# TODO: point to a specific version to Terraform/providers (aws) 
# you can use the semantic version.terraform
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
  key_name = "terraform"
  private_key_path = "terraform.pem"
}

resource "aws_security_group" "projectmodule2_sec_group" {
	name   = "projectmodule2_sec_group"
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
		from_port   = 6576
		to_port     = 6576
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
resource "aws_iam_policy" "demo-s3-policy" {
  name        = "S3-Bucket-Access-Policy"
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

resource "aws_iam_role" "test_role" {
  name = "test_role"

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

resource "aws_iam_policy_attachment" "demo-attach" {
  name       = "demo-attachment"
  roles      = [aws_iam_role.test_role.name]
  policy_arn = aws_iam_policy.demo-s3-policy.arn
}
resource "aws_iam_instance_profile" "demo-profile" {
  name = "demo_profile"
  role = aws_iam_role.test_role.name
}
resource "aws_instance" "ansible_provisioning_server" {
  ami = local.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  vpc_security_group_ids =[aws_security_group.projectmodule2_sec_group.id]
  key_name = local.key_name
  iam_instance_profile = aws_iam_instance_profile.demo-profile.name

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
sudo apt install ansible -y
sudo apt install git -y
sudo apt install unzip -y
sudo apt install awscli -y
sudo apt install jenkins -y
sudo apt install openjdk-11-jdk -y
sudo systemctl start jenkins  
EOF

# TODO: Try using aws user data to run at boot time
# TODO: Have the content on a script
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-add-repository -y ppa:ansible/ansible",
  #     "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null", 
  #     "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",     
  #     "sudo apt update",

  #     "sudo apt install ansible -y",
  #     "sudo apt install git -y",
  #   #   # upload ansible dir
  #   #   # make sure that the inventory file has the ip that was spun up for the worker
  #   #   # USE AN S3 BUCKET - install AWS tools locally - so you can hold the ansible dir
  #   #   "git clone https://reematcs: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@github.com/reematcs/Module2_Project.git",
  #   #   "sudo apt install jenkins -y",
  #   #   "sudo systemctl start jenkins",
  #   #   "sudo apt install openjdk-11-jdk -y",
  #   ]
  # }

}

resource "aws_instance" "ansible_worker" {
  ami = local.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  vpc_security_group_ids =[aws_security_group.projectmodule2_sec_group.id]
  key_name = local.key_name
  iam_instance_profile = aws_iam_instance_profile.demo-profile.name

  tags = {
    Name = "Ansible_Provisioning_Worker"
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
sudo apt install awscli -y
EOF
}