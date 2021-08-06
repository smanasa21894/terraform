resource "aws_security_group" "tomcat" {
  name        = "tomcat"
  description = "Allow alb inbound traffic"
  vpc_id      = aws_vpc.petclinic.id

  ingress {
    description     = "tomcat from VPC"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb.id}"]

  }

  ingress {
    description     = "tomcat from VPC"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.envname}-tomcat-sg"
  }
}


data "template_file" "user_data" {
  template = file("tomcat_install.sh")

}


resource "aws_instance" "tomcat" {
  ami                    = var.ami
  instance_type          = var.type
  subnet_id              = aws_subnet.privatesubnet[0].id
    vpc_security_group_ids = ["${aws_security_group.tomcat.id}"]
  user_data              = data.template_file.user_data.rendered


  tags = {
    Name = "${var.envname}-tomcat"
  }
}