// Show public IP
output "public_ip" {
  value = aws_instance.myInstance.public_ip
}

//

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

