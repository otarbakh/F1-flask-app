variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "flask-key"
}

variable "my_ip" {
  description = "Your IP address for SSH access"
  default     = "93.177.143.187/32"
}
