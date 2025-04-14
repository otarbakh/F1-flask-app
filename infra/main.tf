
data "aws_vpc" "default" {
  default = true
}

# Create a security group to allow SSH and HTTP access
resource "aws_security_group" "f1_sg" {
  name        = "f1-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# AWS Provider
provider "aws" {
  region = var.aws_region
}

# EC2 Instance for Flask App
resource "aws_instance" "f1_flask_app" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 for us-east-1
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.f1_sg.id]

  tags = {
    Name = "F1-Flask-App"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "docker run -d -p 80:5000 yourdockerhubusername/f1-flask-app" # Replace with your actual Docker Hub image
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("f1-key.pem")
      host        = self.public_ip
    }
  }
}
