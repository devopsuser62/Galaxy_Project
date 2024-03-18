resource "aws_security_group" "bastion-host" {
  vpc_id      = aws_vpc.main.id
  name        = "bastion-host"
  description = "Security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["45.25.35.99/32"]
  }
  tags = {
    Name = "Bastion-Host"
  }
}

resource "aws_security_group" "load-balancer" {
  vpc_id      = aws_vpc.main.id
  name        = "load-balancer"
  description = "Security group that allows http, https and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Load-Balancer"
  }
}

resource "aws_security_group" "my-Devops" {
  vpc_id      = aws_vpc.main.id
  name        = "my-Devops"
  description = "Security group that allows bastion-host and load-balancer and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.bastion-host.id}"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = ["${aws_security_group.load-balancer.id}"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${aws_security_group.load-balancer.id}"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = ["${aws_security_group.load-balancer.id}"]
}
  tags = {
    Name = "MyDevOps"
  }
}
