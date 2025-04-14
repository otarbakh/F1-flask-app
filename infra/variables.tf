variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default     = "f1-key"
  description = "The key name to access the EC2 instance"
}

variable "my_ip" {
  default     = "93.177.143.187/32"
  description = "Your IP address for SSH access"
}
