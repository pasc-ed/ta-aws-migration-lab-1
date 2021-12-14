resource "aws_db_instance" "database" {
  allocated_storage = 10
  engine            = "mysql"
  engine_version    = "5.7.22"
  instance_class    = "db.t2.micro"
  identifier        = "database-1"
  username          = "admin"
  password          = "Password123"

  db_subnet_group_name   = aws_db_subnet_group.db_sg.name
  vpc_security_group_ids = [aws_security_group.target_db.id]
}