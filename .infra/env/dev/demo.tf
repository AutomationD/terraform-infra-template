// Demo Host
resource "aws_instance" "demo" {
  ami                         = data.aws_ami.ubuntu_bionic.id
  key_name                    = var.ec2_key_pair_name
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.demo.id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Terraform = "true"
    Env       = var.env
    Name      = "${var.env}-demo"
  }
}

resource "aws_security_group" "demo" {
  name   = "${var.env}-demo"
  vpc_id = module.vpc.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = "true"
    Env       = var.env
    Name      = "${var.env}-demo"
  }
}
