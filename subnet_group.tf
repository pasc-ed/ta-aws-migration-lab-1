resource "aws_db_subnet_group" "db_sg" {
  name        = "database-subnet-group"
  description = "Subnets where RDS will be deployed"
  subnet_ids  = [
    data.aws_subnet.private_db_a.id,
    data.aws_subnet.private_db_b.id
  ]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_dms_replication_subnet_group" "db_replication_sg" {
  replication_subnet_group_description = "Default VPC Subnet Group for DMS"
  replication_subnet_group_id          = "dms-subnet-group"

  subnet_ids = [
    data.aws_subnet.public_db_a.id,
    data.aws_subnet.public_db_b.id,
  ]

  tags = {
    Name = "dms-subnet-group"
  }
}