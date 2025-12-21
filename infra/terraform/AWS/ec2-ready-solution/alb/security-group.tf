# Security Group for Application Load Balancer
resource "aws_security_group" "alb" {
  name_prefix = "${var.prefix}-${var.env}-alb-"
  vpc_id      = var.vpc_id
  description = "Security group for Application Load Balancer"

  # HTTP ingress from internet
  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  # HTTPS ingress from internet
  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  # Allow all outbound traffic to targets
  egress {
    description = "All outbound traffic to targets"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # Allow outbound HTTPS for health checks and other services
  egress {
    description = "HTTPS outbound for external services"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound HTTP for health checks and other services
  egress {
    description = "HTTP outbound for external services"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name        = "${var.prefix}-${var.env}-alb-sg"
    Environment = var.env
    Type        = "ALB Security Group"
  })

  lifecycle {
    create_before_destroy = true
  }
}

# Security Group Rule for target group communication
resource "aws_security_group_rule" "alb_to_targets" {
  type                     = "egress"
  from_port                = var.target_group_port
  to_port                  = var.target_group_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb.id
  source_security_group_id = var.target_security_group_id
  description              = "ALB to target instances on port ${var.target_group_port}"
}

# Optional: Additional security group rules for custom ports
resource "aws_security_group_rule" "custom_ingress" {
  count       = length(var.custom_ingress_rules)
  type        = "ingress"
  from_port   = var.custom_ingress_rules[count.index].from_port
  to_port     = var.custom_ingress_rules[count.index].to_port
  protocol    = var.custom_ingress_rules[count.index].protocol
  cidr_blocks = var.custom_ingress_rules[count.index].cidr_blocks
  security_group_id = aws_security_group.alb.id
  description = var.custom_ingress_rules[count.index].description
}