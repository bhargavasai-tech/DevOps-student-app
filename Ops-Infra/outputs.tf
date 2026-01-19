output "student_server_public_ip" {
  description = "Public IP of Student CGPA EC2 Server"
  value       = aws_instance.student_server.public_ip
}
