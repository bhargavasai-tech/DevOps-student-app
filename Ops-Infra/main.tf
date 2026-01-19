provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# --- Security Group ---
resource "aws_security_group" "student_docker_sg" {
  name        = "student-docker-sg"
  description = "Allow SSH and Flask App Port 5000"

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Student CGPA Flask App"
    from_port   = 5000
    to_port     = 5000
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

# --- EC2 Instance ---
resource "aws_instance" "student_server" {
  ami           = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  key_name      = var.key_name

  security_groups = [aws_security_group.student_docker_sg.name]

  tags = {
    Name = "Student-CGPA-Docker-Server"
  }

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf remove -y podman podman-docker
              dnf install -y docker git ansible-core
              systemctl start docker
              systemctl enable docker
              usermod -a -G docker ec2-user
              EOF
}
