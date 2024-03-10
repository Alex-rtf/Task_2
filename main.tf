// Terraform version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

//To generate Instance with functions
//To generate EC2
provider aws {
   region = var.region
}

resource "aws_instance" "MyInstance" {
  ami = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }

    root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  //Associate the security group with the EC2 instance
  vpc_security_group_ids = [var.security_group_name]
  //Associate the security key with the EC2 instance
  key_name = var.key_name

  //Install Docker and Docker compose on EInstance

   connection {
      type        = ssh
      host        = self.public_ip
      user        = var.username
      private_key = file("${var.path_local}${var.key_name}.pem")
   }
   
  provisioner "file" {
  source="${var.path_local}Script.sh"
  destination="${var.path_instance}Script.sh"
  }
  
  provisioner "remote-exec" {
  inline=[
  "sudo chmod +x ${var.path_instance}Script.sh",
  "sudo ${var.path_instance}Script.sh"
  ]
  }

}