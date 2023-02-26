resource "aws_alb"  "my-load-balancer" {
  name = "my-load-balancer"
  subnets = ["${aws_subnet.main-public-1.id}", "${aws_subnet.main-public-2.id}"]
  security_groups = ["${aws_security_group.load-balancer.id}"]
  tags = {
    Name = "My-Load-Balancer"
  }
}

#Target Group

resource "aws_alb_target_group" "frontend-target-group" {
  name = "alb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.main.id}"
}

#Listeners

resource "aws_alb_listener" "frontend-listeners" {
  load_balancer_arn = "${aws_alb.my-load-balancer.arn}"
  port = 80
  default_action {
    target_group_arn = "${aws_alb_target_group.frontend-target-group.arn}"
    type = "forward"
}
}

#Attaching Instances to the target group

resource "aws_alb_target_group_attachment" "frontend-attachment-1" {
  target_group_arn = "${aws_alb_target_group.frontend-target-group.arn}"
  target_id  = "${aws_instance.web1.id}"
}

resource "aws_alb_target_group_attachment" "frontend-attachment-2" {
  target_group_arn = "${aws_alb_target_group.frontend-target-group.arn}"
  target_id  = "${aws_instance.web2.id}"
}

