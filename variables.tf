variable "region" {
  default = "ap-south-1"
}

variable "azs" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "customer_gateway_ip" {
  type        = string
  sensitive   = true
  description = "Public IP of on-prem firewall"
}

variable "on_prem_cidr" {
  default     = "192.168.1.0/24"
  description = "On-prem network range"
}

variable "ec2_ami" {
  description = "AMI ID for EC2 instance"
  default     = "ami-0f58b397bc5c1f2e8" # Amazon Linux 2 (ap-south-1)
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
