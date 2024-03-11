///////Instance variables///////
variable "instance_name" {
  description = "Instanse Name"
  type        = string
  default     = "MyInstance"
}

variable "region" {
  description = "Region"
  type        = string
  default     = "eu-central-1"
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-04dfd853d88e818e8"
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "volume_type" {
  description = "Volume Type"
  type        = string
  default     = "gp2"
}

variable "volume_size" {
  description = "Volume Size"
  type        = number
  default     = 10
}

///////Key Variables///////
variable "key_name" {
  description = "SSH Key Name"
  type        = string
  default     = "MyInstanceKey"
}

///////Security Group///////
variable "security_group_name" {
  description = "SSH Key Name"
  type        = string
  default     = "my_security_group"
}

variable "ingress_cidr_blocks" {
  description = "List of CIDR blocks for ingress traffic"
  type        = list(string)
  default     = ["176.37.211.149/32", "0.0.0.0/0"]
}

///////User Variables///////
variable "username" {
  description = "Instance username for SSH connection"
  type        = string
  default     = "ubuntu"
}

///////File Path///////
variable "path_local" {
  description = "File Path Local Machine"
  type        = string
  default     = "D:/DevOps/Task_2/"
}

variable "path_instance" {
  description = "File Path Local Machine"
  type        = string
  default     = "/tmp/"
}

/////Secret Manager/////
variable "my_secret_name" {
  description = "Secret Name"
  type        = string
  default     = "my_test_secret_666"
}
