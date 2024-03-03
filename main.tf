// Terraform version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

/////////////////////To generate Security Group, Key, Key Pair, .pem file///////////////////////
resource "aws_security_group" "mySecurityGroup" {
  name        = "mySecurityGroup"
  description = "My Security Group for SSH Connection"

  // Define ingress rules (inbound traffic)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["176.37.211.149/32"]  // Allow SSH access from my IP
  }

    ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

// To Generate Private Key
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Create Key Pair for Connecting EC2 via SSH
resource "aws_key_pair" "key_pair" {
  key_name   = "myInstanceKey"
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

// Save PEM file locally
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = "myInstanceKey.pem"
}

/////////////////////To generate Instance with functions///////////////////////
// To generate EC2
provider "aws" {
   region = "eu-central-1"

}

resource "aws_instance" "myInstance" {
  ami = "ami-04dfd853d88e818e8"
  instance_type = "t2.micro"

  tags = {
    Name = "myInstance"
  }

    root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }

  // Associate the security group with the EC2 instance
  vpc_security_group_ids = [aws_security_group.mySecurityGroup.id]
  // Associate the security key with the EC2 instance
  key_name = aws_key_pair.key_pair.key_name

 connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("D:/DevOps/Task_2/myInstanceKey.pem")
   }
   
   provisioner "file" {
  source="D:/DevOps/Task_2/Script.sh"
  destination="/tmp/Script.sh"
  }
  
  provisioner "remote-exec" {
  inline=[
  "sudo chmod +x /tmp/Script.sh",
  "sudo /tmp/Script.sh"
  ]
  }

}

// Show public  IP
output "public_ip" {
  value = aws_instance.myInstance.public_ip
}