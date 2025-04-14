provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "f1_flask_app" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI for us-east-1 (make sure it is correct)
  instance_type = "t2.micro"

  tags = {
    Name = "F1-Flask-App"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "docker run -d -p 80:5000 yourdockerhubusername/f1-flask-app" # Replace this with your Docker Hub username and image
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/path/to/your-key.pem") # Replace with the actual path to your private key
      host        = self.public_ip
    }
  }

  key_name = "f1-key"
}
