/////////////////////To generate Security Group, Key, Key Pair, .pem file///////////////////////
resource "aws_security_group" "my_security_group" {
  description = "My Security Group for SSH Connection"
  name        = var.security_group_name

/////Define ingress rules (inbound traffic)/////
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_blocks[0]]  // Allow SSH access from my IP
  }

    ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_blocks[1]]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_blocks[1]]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.ingress_cidr_blocks[1]]
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
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

// Save PEM file locally
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = "${var.key_name}.pem"
}

resource "random_password" "my_secret_password" {
length           = 8
special          = true
override_special = "!@#$*"//provide special symbols
}

resource "aws_secretsmanager_secret" "my_test_secret_3" {
name = var.my_secret_name
}

resource "aws_secretsmanager_secret_version" "my_test_secret_3_version" {
secret_id     = aws_secretsmanager_secret.my_test_secret_3.id
secret_string = random_password.my_secret_password.result

}
