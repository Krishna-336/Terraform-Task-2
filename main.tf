provider "aws" {
  region = "us-east-1"
  alias  = "useast"
}

provider "aws" {
  region = "us-west-1"
  alias  = "uswest"
}

resource "aws_instance" "east_instance" {
  provider      = aws.useast
  ami           = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "Nginx-East"
  }
}

resource "aws_instance" "west_instance" {
  provider      = aws.uswest
  ami           = "ami-038bba9a164eb3dc1"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "Nginx-West"
  }
}
