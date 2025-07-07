output "ec2_instance_id" {
  value = aws_instance.private_ec2.id
}

output "vpn_connection_id" {
  value = aws_vpn_connection.vpn.id
}
