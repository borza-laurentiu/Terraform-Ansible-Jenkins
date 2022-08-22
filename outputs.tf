output "EC2_jenkins_IP" {
    value = aws_instance.jenkins-server.public_ip //logs the IP address of the EC2 
}

output "EC2_ansible_IP" {
    value = aws_instance.ansible-machine.public_ip //logs the IP address of the EC2 
}

# output "SG_ID" {
#     value = aws_security_group.sgPublic.id
# }

# output "private_subnet_1" {
#     value = aws_subnet.subprivate1.id
# }

# output "private_subnet_2" {
#     value = aws_subnet.subprivate2.id
# }