resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]#aws_security_group.lb_sg.id]
  subnets            = [var.subnet_id_1,var.subnet_id_2]
  
  tags = {
    Environment = "production"
  }
}
resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = var.port
  protocol = var.http
  vpc_id   = var.vpc_id
}
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = var.target_id
  port             = var.port
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = var.port
  protocol          = var.http
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    target_group_arn = aws_lb_target_group.test.arn
    type = "forward"
    }
}
# resource "aws_lb_listener" "front_end_https" {
#   load_balancer_arn = aws_lb.test.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     target_group_arn = aws_lb_target_group.test.arn
#     type = "forward"
#     }
# }