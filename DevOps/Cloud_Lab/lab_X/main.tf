resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("${var.PATH_TO_PUBLIC_KEY}")

}

resource "aws_instance" "web1" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  #The VPC subnet
  subnet_id = aws_subnet.main-private-1.id

  #The Security group
  vpc_security_group_ids = ["${aws_security_group.my-Devops.id}"]

  #role
  iam_instance_profile = "${aws_iam_instance_profile.k8s-worker-instanceprofile.name}"

  provisioner "local-exec" {
    command = "echo ${aws_instance.web1.private_ip} >> /tmp/private_ips.txt"
}
    tags = {
    Name = "Kubernetes_Worker"
  }
}


resource "aws_instance" "web2" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  #The VPC subnet
  subnet_id = aws_subnet.main-private-2.id

  #The Security group
  vpc_security_group_ids = ["${aws_security_group.my-Devops.id}"]

  #role
  iam_instance_profile = "${aws_iam_instance_profile.k8s-worker-instanceprofile.name}"

  provisioner "local-exec" {
    command = "echo ${aws_instance.web2.private_ip} >> /tmp/private_ips.txt"
  }
    tags = {
    Name = "NFS_Server"
  }
}


resource "aws_instance" "web3" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.medium"
  key_name      = aws_key_pair.mykey.key_name

  #The VPC subnet
  subnet_id = aws_subnet.main-private-3.id

  #The Security group
  vpc_security_group_ids = ["${aws_security_group.my-Devops.id}"]

  #role
  iam_instance_profile = "${aws_iam_instance_profile.k8s-master-instanceprofile.name}"

  provisioner "local-exec" {
    command = "echo ${aws_instance.web3.private_ip} >> /tmp/private_ips.txt"
  }   
    tags = {
    Name = "Kubernetes-Master"
  }
}

output "Kubernetes-Master" {
  value       = aws_instance.web3.public_ip
  description = "The public IP address of the server"
}

resource "aws_instance" "web4" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.mykey.key_name

  #The VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  #The Security group
  vpc_security_group_ids = ["${aws_security_group.bastion-host.id}"]

  #role
  iam_instance_profile = "${aws_iam_instance_profile.k8s-master-instanceprofile.name}"


provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }
provisioner "file" {
    source = "/tmp/private_ips.txt"
    destination = "/tmp/hosts"
  }
provisioner "local-exec" {
    command = "rm -f /tmp/private_ips.txt"
}
connection {
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file("${var.PATH_TO_PRIVATE_KEY}")
    host        = element(aws_instance.web4.*.public_ip, 0)
  }
    tags = {
    Name = "Bastion-Host"
  }
}

output "Bastion-Host" {
  value       = aws_instance.web4.public_ip
  description = "The public IP address of the server"
}

