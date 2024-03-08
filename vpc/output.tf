output "aws_subnet" {
    value = aws_subnet.main.id
}
output "aws_security_group" {
    value = aws_security_group.allow_tls.id
}

output "aws_subnet_2_id" {
    value = aws_subnet.second_subnet.id
}
output "aws_security_group_id" {
    value = aws_security_group.allow_tls.id
}
output "vpc_id" {
    value=aws_vpc.main.id
}