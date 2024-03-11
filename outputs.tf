// Show public IP
output "public_ip" {
  value = aws_instance.myInstance.public_ip
}

//
output "aws_account_name" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

