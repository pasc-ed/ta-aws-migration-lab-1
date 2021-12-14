resource "aws_dms_replication_instance" "test" {
  allocated_storage = 50

  engine_version = "3.4.5"
  multi_az = true

  publicly_accessible         = true
  replication_instance_class  = "dms.t3.medium"
  replication_instance_id     = "replication-instance"
  replication_subnet_group_id = aws_dms_replication_subnet_group.db_replication_sg.id

  tags = {
    Name = "replication-instance"
  }

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]
}

resource "aws_dms_endpoint" "source" {
  database_name               = "wordpress-db"
  endpoint_id                 = "source-endpoint"
  endpoint_type               = "source"
  engine_name                 = "mysql"
  extra_connection_attributes = ""

  server_name = "18.207.97.18"
  username    = "wordpress-user"
  password    = "AWSRocksSince2006" # secretmanager
  port        = 3306

  tags = {
    Name = "source-endpoint"
  }
}

resource "aws_dms_endpoint" "destination" {
  endpoint_id                 = aws_db_instance.database.identifier
  endpoint_type               = "target"
  engine_name                 = "mysql"
  extra_connection_attributes = "parallelLoadThreads=1; initstmt=SET FOREIGN_KEY_CHECKS=0"

  server_name = split(":", aws_db_instance.database.endpoint)[0] # ["database-1.rds-asdasas.amazonaws.com", "3306"]
  username    = "admin"
  password    = "Password123"
  port        = 3306

  tags = {
    Name = "target-endpoint"
  }
}




# resource "aws_dms_replication_task" "task" {
#   replication_task_id      = "replication-cdc"
#   migration_type           = "full-load-and-cdc"
#   replication_instance_arn = aws_dms_replication_instance.test.replication_instance_arn
#   source_endpoint_arn      = aws_dms_endpoint.source.endpoint_arn
#   target_endpoint_arn      = aws_dms_endpoint.destination.endpoint_arn

#   table_mappings = "{\"rules\":[{\"rule-type\":\"selection\",\"rule-id\":\"1\",\"rule-name\":\"1\",\"object-locator\":{\"schema-name\":\"%\",\"table-name\":\"%\"},\"rule-action\":\"include\"}]}"



#   tags = {
#     Name = "test"
#   }
# }