output "sg_name" {
    value = aws_security_group.web_traffic.name
}


output "instance_id" {
    value = aws_instance.web_server.id
}
