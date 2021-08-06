resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.petclinic.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.envname}-bastion-sg"
  }
}


#key


resource "aws_key_pair" "petclinic" {
  key_name   = "petclinic-key"
  public_key =  "ssh-rsa  AAAAB3NzaC1yc2EAAAADAQABAAABgQCwWwpFR/t6yrk++Qdt+PWkPHsdNXe0mFh08qvesl/DU99yfxPw02j0JV1xGdb78EohEaQ6WCre0OsEvBcpXTRdDgWnEVbyHs2ktWrXKcYXy31HNJ0bVaXgXrMaPIVxuYBZnG6XcP/9kcAk+E9/qPsblyL5GQesBjMn0z3yzrhsaeW69WgsthnvaT/y+fepFjc8J6W/CvqAp8/ZEZMgra30lra1E4+cOojmhGOZ9kg3WEG4swXaCTP0hfUTlUwIe0iNOr1r9D1Qh0c1pBYBuEb5Ua2URAQLrhfM1iThLgt3pZqqZYNSh5twW21VdG9VCdvRjQkYjZBnU0gPVajpAaWkzJVsqZLmTGiPf/G04h4+b12ho9OkkKBNE5SGDgJBZF3bxsgqz2sTFPw/gttHSfjYz6SQVwueDIF8w0/XKuGzMHFW6YbMeDt7ocW/iQ+su5ZWGhqXw0QQJEyvN1h1YofJZKaErWCr/PbXqIDdRrNUzTcuikreGyc2GkQTB1ah6Qs= Manasa@Manasa-PC"
  }


# ec2

resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.type
  subnet_id              = aws_subnet.publicsubnet[0].id
  key_name               = aws_key_pair.petclinic.id
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]


  tags = {
    Name = "${var.envname}-bastion"
  }

}