data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "bastion_vm" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.machine_details["type"]
  subnet_id                   = module.network.subnets["public1"].id
  vpc_security_group_ids      = [aws_security_group.allow_ssh_public.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.public_key_pair.key_name
  user_data                   = <<-EOF
             #!/bin/bash
             echo '${tls_private_key.rsa_generator.private_key_pem}' > /home/ubuntu/private_key.pem
             chmod 400 /home/ubuntu/private_key.pem
            EOF

  tags = {
    Name = "${var.common_resource_name}_Bastion_EC2"
  }

  provisioner "local-exec" {
    command = "echo The server IP address is ${self.public_ip}"
  }
}

resource "aws_instance" "private_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.machine_details["type"]
  subnet_id                   = module.network.subnets["private1"].id
  vpc_security_group_ids      = [aws_security_group.allow_ssh_private.id]
  associate_public_ip_address = false
  key_name                    = aws_key_pair.public_key_pair.key_name

  tags = {
    Name = "${var.common_resource_name}_Private_EC2"
  }
}
