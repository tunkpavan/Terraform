provider "aws" {
   region     = "ap-south-1"
   
}

resource "aws_instance" "ec2_example" {

    ami = "ami-0d8633ffb1a5574db"  
    instance_type = "t2.micro" 
    tags = {
        Name = "Terraform EC2"
    }

  provisioner "local-exec" {
    command = "touch hello-devops.txt"
  }
}