variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "The type of EC2 instance to create"
  default     = "t2.micro"
}

variable "key_name" {
  description = "f1-key"
}

variable "my_ip" {
  description = "93.177.143.187/32"
}
