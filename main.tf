provider "aws" {
  region = "ap-south-1"
}

# 1. Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "11.0.0.0/16"
}

resource "aws_subnet" "my_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "11.0.1.0/24"
}

resource "aws_subnet" "my_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "11.0.2.0/24"
}
resource "aws_subnet" "my_subnet3" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "11.0.3.0/24"
}
# 2. Create a security group
resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# 4. Attach the Internet Gate
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.my_vpc.id
  route_table_id = aws_route_table.my_route_table.id
}

output "VPCID" {
  value = aws_vpc.my_vpc.id
}


# 5. Create an EC2 instance
resource "aws_instance" "machine1" {
  ami             = "ami-0a1b648e2cd533174"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.my_subnet1.id
  security_groups = [aws_security_group.my_security_group.id]
  key_name        = "awslogin.pem" # Assuming your private key file is named "awslogin.pem"
}

resource "aws_instance" "machine2" {
  ami             = "ami-0a1b648e2cd533174"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.my_subnet2.id
  security_groups = [aws_security_group.my_security_group.id]
  user_data       = file("jenkins_java_script.sh")
  key_name        = "awslogin.pem" # Assuming your private key file is named "awslogin.pem"
  associate_public_ip_address = true
}

resource "aws_instance" "machine3" {
  ami             = "ami-0a1b648e2cd533174"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.my_subnet3.id
  security_groups = [aws_security_group.my_security_group.id]
  user_data       = file("java_docker_script.sh")
  key_name        = "awslogin.pem" # Assuming your private key file is named "awslogin.pem"
  associate_public_ip_address = true
}

# 6. Elastic IP creation
resource "aws_eip" "elastic_ip" {
  instance = aws_instance.machine1.id
}

# 7. Attach 3 subnet to route table
resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.my_subnet1.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.my_subnet2.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "a3" {
  subnet_id      = aws_subnet.my_subnet3.id
  route_table_id = aws_route_table.my_route_table.id
}
output "PublicIPAddress" {
  value = aws_eip.elastic_ip.public_ip
}