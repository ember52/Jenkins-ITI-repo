resource "aws_security_group" "allow_ssh_public" {
  name        = "allow_ssh_public"
  description = "security group to allow ssh connection"
  vpc_id      = module.network.vpc.id

  ingress {
    description = "ssh from outside"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Public 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_ssh_public"
  }
}

resource "aws_security_group" "allow_ssh_private" {
  name        = "allow_ssh_private"
  description = "security group to allow ssh connection"
  vpc_id      = module.network.vpc.id

  # allow ssh from vpc cidr_block
  ingress {
    description = "ssh from inside"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow port 3000 from vpc cidr_block
  ingress {
    description = "from vpc"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Public 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_ssh_private"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "security group to allow HTTP traffic"
  vpc_id      = module.network.vpc.id

  # allow HTTP from anywhere
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Public 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}
