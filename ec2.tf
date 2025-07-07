resource "aws_security_group" "private_ec2_sg" {
  name        = "ec2-allow-icmp"
  description = "Allow ICMP (ping) from on-prem network"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["192.168.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "ec2-sg"
  })
}

resource "aws_instance" "private_ec2" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.private[0].id
  vpc_security_group_ids      = [aws_security_group.private_ec2_sg]
  associate_public_ip_address = false

  tags = merge(local.tags, {
    Name = "private-ec2"
  })
}
