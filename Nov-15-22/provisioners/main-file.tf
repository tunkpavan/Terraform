provider "aws" {
   region     = "ap-south-1"
}

resource "aws_instance" "ec2_example" {

    ami = "ami-0d8633ffb1a5574db"  
    instance_type = "t2.micro" 
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "file" {
    source      = "/home/ubuntu/test-file.txt"
    destination = "/home/ubuntu/test-file.txt"
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/ubuntu/.ssh/id_rsa")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8lo+o+0DtlUxGyFTVFxvzSZf2daxnXS/RCb7yudjU1SG4CubENfHnuzjpxvp1ZAWeEMwqlAyx3q2PNbY4+ci6ceLHjrau2oKtfqBbPHdMCU+uaqOHAMeihaHhn84GkmPpLjbDRVfE9G7J1N3PX7Ghpl/DOvNXE9leaThWQJ/9FOGtDYMAb6/VKgwRnRxqk1/em7po7kxLCW0XL8LaBYNV8t2tPpT25lrGA6xHnSxC1tLV2diUGoqyYLSEZ3pVvQ6VM8wa8aCPGdN9ef6zjAMtcoDft1Am+w0pWuhm8n+hy/YdYNt8o0BvPs9InBJpiOjgWdiV5fyKKxeI97Qrykd7 ubuntu@ip-172-31-2-106"
}