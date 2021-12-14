resource "aws_security_group" "app_sg" {
  name        = "RI-SG"
  description = "Security Group for Replication Instance"
  vpc_id      = data.aws_vpc.main.id

  tags = {
    Name = "RI-SG"
  }
}

# EGRESS
resource "aws_security_group_rule" "all_access" {
  type              = "egress" # OUTBOUND RULE
  from_port         = 0
  to_port           = 0
  protocol          = -1 #both TCP and UDP
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app_sg.id
}

resource "aws_security_group" "target_db" {
  name        = "DB-SG"
  description = "Database SG for target"
  vpc_id      = data.aws_vpc.main.id

  tags = {
    Name = "DB-SG"
  }
}

# EGRESS
resource "aws_security_group_rule" "mysql" {
  type                     = "ingress" # INBOUND
  from_port                = 3306 # MySQL port
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_sg.id
  security_group_id        = aws_security_group.target_db.id
}

resource "aws_security_group_rule" "all_access_db" {
  type              = "egress" # OUTBOUND
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.target_db.id
}
