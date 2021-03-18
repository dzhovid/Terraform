data "aws_route53_zone" "zone" {
  name         = var.domain
}
resource "aws_route53_record" "jenkins" {
  zone_id = data.aws_route53_zone.zone.id
  name    = "${var.record}.${var.domain}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web.public_ip]
}