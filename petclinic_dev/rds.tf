resource "aws_security_group" "rds" {
  name        = "rds"
  description = "Allow alb inbound traffic"
  vpc_id      = aws_vpc.petclinic.id

  ingress {
    description     = "rds from VPC"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]

  }

  ingress {
    description     = "rds from VPC"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.tomcat.id}"]

  }
 
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.envname}-rds-sg"
  }
}