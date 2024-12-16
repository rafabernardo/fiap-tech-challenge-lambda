resource "aws_apigatewayv2_vpc_link" "vpc_link" {
  name               = "example-vpc-link"
  security_group_ids = [aws_security_group.sg.id] # Replace with your security group
  subnet_ids         = [for subnet in data.aws_subnet.subnet : subnet.id if subnet.availability_zone != "${var.aws_region}e"]
}
