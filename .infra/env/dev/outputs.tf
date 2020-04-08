
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "demo_public_ip" {
  value = aws_instance.demo.public_ip
}
