provider "aws" {
  region = "ap-south-1"
}

#1 create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"

}
#2. create a security group
resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#3. create a EC2 instance

resource "aws_instance" "machine1" {
  ami = "ami-0a1b648e2cd533174"  
  instance_type = "t2.micro"
#   subnet_id = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.my_security_group.id]
}

resource "aws_instance" "machine2" {
  ami = "ami-0a1b648e2cd533174"  
  instance_type = "t2.micro"
#   subnet_id = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.my_security_group.id]
  user_data = file("jenkins_java_script.sh")
}
resource "aws_instance" "machine3" {
  ami = "ami-0a1b648e2cd533174"  
  instance_type = "t2.micro"
#   subnet_id = aws_subnet.my_subnet.id
  security_groups = [aws_security_group.my_security_group.id]
  user_data = file("java_docker_script.sh")
}

#elastic IP creation
resource "aws_eip" "elastic_ip" {
  instance = aws_instance.machine1.id
}