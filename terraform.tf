locals {
  ami_id = "ami-0557a15b87f6559cf"
  vpc_id = "vpc-02290181f0427b239"
  ssh_user = "ubuntu"
  key_name = "terraform"
  private_key_path = "terraform.pem"
}
provider "aws" {
	
	region     = "us-east-1"
	access_key = "ASIA37M36QKRYGJ2UHVV"
	secret_key = "pvLXOOi7Oytj5gkuQJt/LNKZI6fGL1kdZg/mXukR"
	token = "FwoGZXIvYXdzEDQaDAHNUrtv5FErlYL2ySK3AcDeyxM2asm7dmoltjHt0tavnJYcKrqtE/CBhzZqEomY0bwRdLoi8x7xFHf+mDPdSVZQXAR8wRfUfaE+95O8EFGhHNV8dMkZjAmdNUx9TOBMunaPiuJf/5TuqkOkMhhsNOVgVJdFUByPHfHKjK/AJ5YfF9+OLX3N8/56vK/pmxklsz1Stimq9p+bzAxUegmiESP3Jn3q7CT1Yf/zJ1d2lTIUzFiPpNrjiQRd0dApXwds4c3jFFNHuyilwNKfBjItznvBRSBTcTZxoLxjv+ZGXR9fpmWsaD0L86sgiG6lNcr5mgbfQbL0z5R08WZm"
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
  egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_instance" "ansible_provisioning_server" {
  ami = local.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  vpc_security_group_ids =[aws_security_group.projectmodule2_sec_group.id]
  key_name = local.key_name

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
 provisioner "local-exec" {
    inline = [
      "",
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-add-repository -y ppa:ansible/ansible",
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null", 
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",     
      "sudo apt update",
      "sudo apt install openjdk-11-jdk -y",
      "sudo apt install ansible -y",
      "sudo apt install jenkins -y",
      "sudo systemctl start jenkins",
    ]
  }
}

resource "aws_instance" "ansible_provisioning_worker" {
  ami = local.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  vpc_security_group_ids =[aws_security_group.projectmodule2_sec_group.id]
  key_name = local.key_name

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

}