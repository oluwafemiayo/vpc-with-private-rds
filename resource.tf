# aws database subnet group
resource "aws_db_subnet_group" "private_rds_subnet_group" {
  name = "private-rds-subnet-group"
  subnet_ids = module.vpc.private_subnets
}


# Create a security group for the RDS instance
resource "aws_security_group" "rds_sg" {
  name_prefix = "rds_sg_"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks =  var.cidr_blocks
    
  }
}

# Create an RDS instance
resource "aws_db_instance" "private_rds" {
  identifier = "my-private-rds"
  engine = var.engine
  instance_class = var.instance_class
  username = var.username
  password = var.password
  allocated_storage = var.allocated_storage
  skip_final_snapshot = true

# Attach subnet to db instance
  db_subnet_group_name = aws_db_subnet_group.private_rds_subnet_group.name

# Attach security group to db instance
  vpc_security_group_ids = [aws_security_group.web_traffic.id]


  tags = {
    Name = "myrds"
  }

}


# Create Elastic IP for the instance
resource "aws_eip" "eip" {
  instance = aws_instance.web_server.id
}

# Create a new ec2 instance for Jenkins
resource "aws_instance" "web_server" {
    ami = data.aws_ami.amzlinux2.id
    instance_type = "t2.medium"
    key_name      = "ssh"
    associate_public_ip_address = true
    user_data = file("./website.sh")

    tags = {
        Name = "web-server"
    }
    
    subnet_id     = module.vpc.public_subnets[0]
    vpc_security_group_ids = [aws_security_group.web_traffic.id]
}

# Ec2 Security Group
resource "aws_security_group" "web_traffic" {
    name = "Allow Web Traffic"
    vpc_id = module.vpc.vpc_id

    dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content {
            from_port = port.value
            to_port = port. value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

        dynamic "egress" {
        iterator = port
        for_each = var.egress
        content {
            from_port = port.value
            to_port = port. value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}




