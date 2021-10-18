provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  subnet_id                   = "subnet-0b6ee665d5b518339"
  ami                         = "ami-09e67e426f25ce0d7"
  instance_type               = "t2.micro"
  key_name                    = "key-dev-tf"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.lab_docker_ffaihdw.id]
  root_block_device {
    encrypted   = true
    volume_size = 20
  }
  tags = {
    Name = "ec2-lab_docker_ffaihdw"
  }
}

resource "aws_security_group" "lab_docker_ffaihdw" {
  name        = "sg_lab_docker_ffaihdw"
  description = "Permitir porta SSH e HTTP acesso de entrada"
  vpc_id      = "vpc-080da39cf7b8a7fdc"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "HTTP from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      description : "Libera dados da rede interna"
      prefix_list_ids = []
      security_groups = []
      self            = false
    }
  ]

  tags = {
    Name = "sg_lab_docker_ffaihdw"
  }
}

output "dns" {
  description = "DNS publico"
  value       = aws_instance.web.public_dns
}
