provider "aws" {
  region = "ap-south-1"
}
resource "aws_security_group" "Web_Traffic" {
  name        = "Allow web traffic"
  description = "opening ports for ssh and http"
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrule
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "webserver" {
  ami             = var.instance
  instance_type   = var.instancetype
  security_groups = [aws_security_group.Web_Traffic.name]
  key_name        = "Ajay"
  tags = {
    Name = "Webserver1"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo yum install python3-pip -y",
      "sudo pip3 install docker-compose",
      "sudo systemctl enable docker.service",
      "sudo systemctl start docker.service",
      "sudo systemctl status docker.service",
      "sudo mkdir -p /Devops/Conf",
      "sudo cd /Devops/Conf",
      "sudo docker build -t webserver:devops .",
      "sudo docker run --name webserver -p 8080:8080 -d webserver:devops",
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    #private_key = file("~/.ssh/id_rsa")
  }
  #user_data = <<EOF
}


output "result" {
  value = join("", ["http://", aws_instance.webserver.public_ip, ":", "8080"])
}

resource "local_file" "inventory" {
  content  = aws_instance.webserver.public_ip
  filename = "/root/ansible/inventory"
}
