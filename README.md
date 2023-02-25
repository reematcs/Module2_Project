# Name

Using Terraform and Ansible to provision, Jenkins to Automate Maven packing of WAR file and deployment to Tomcat 9

# Description

## Overview

Terraform, an open-source IaC is used to spin up a EC2 server instance, a deployment instance and S3 bucket to upload ansible provisioning playbooks. 
## Directory Structure
```
Module2_Project
├── README.md
├── ansible_provisioning
│   ├── deploy_war.yml
│   ├── deploy_war_role
│   │   ├── README.md
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── tests
│   │       ├── inventory
│   │       └── test.yml
│   ├── localhost
│   │   ├── host-manager.xml
│   │   └── manager.xml
│   ├── maven_build_role
│   │   ├── README.md
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── tests
│   │       ├── inventory
│   │       └── test.yml
│   ├── tomcat-users.xml
│   └── tomcat_playbook.yml
├── aws_terraform.pem
├── bucket.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf

9 directories, 22 files
```

## Summary of Steps Performed:

1. [Terraform:](#terraform)
    1. Spun up S3 bucket
    2. Spun up 2 EC2 instances, provisioning server and deployment, and generated their public and private ips. Attached necessary IAM role to EC2 instances to access S3 bucket.
    3. Placed Ansible provisioning playbooks and roles, with inventory file for deployment ip address. Zipped using Terraform and uploaded to S3 bucket.
    4. Downloaded ansible playbook using awscli commands to EC2 provisioning server. Unzipped. Generated ssh keys to connect with deployment server and uploaded to S3 bucket.
    5. Downloaded and appended ssh public key using awscli commands to deployment instance in authorized_keys.
    6. Used Terraform to run ansible playbooks.
2. [Ansible:](#ansible)
    1. Tomcat setup on deployment server.
    2. Clone and build Hello World WAR file using maven on provisioning server.
    3. Deploy WAR file and restart Tomcat on deployment server.
3. [Jenkins:](#jenkins)
    1. Manual setup of pipeline in [previous step](#ansible)
    2. Testing and validating pipeline.


# Terraform:

# Ansible: 

# Jenkins: 

