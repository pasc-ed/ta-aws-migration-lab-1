data "aws_vpc" "main" {
  tags = {
    Name = "TargetVPC"
  }
}

data "aws_subnet" "private_db_a" {
  filter {
    name   = "tag:Name"
    values = ["TargetVPC-private-a-db"]
  }
}

data "aws_subnet" "private_db_b" {
  filter {
    name   = "tag:Name"
    values = ["TargetVPC-private-b-db"]
  }
}

data "aws_subnet" "public_db_a" {
  filter {
    name   = "tag:Name"
    values = ["TargetVPC-public-a"]
  }
}

data "aws_subnet" "public_db_b" {
  filter {
    name   = "tag:Name"
    values = ["TargetVPC-public-b"]
  }
}