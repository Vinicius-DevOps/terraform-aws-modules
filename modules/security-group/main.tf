# Security Group
resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

# Ingress Rules
resource "aws_security_group_rule" "ingress" {
  count                    = length(var.ingress_rules)
  type                     = "ingress"
  from_port                = var.ingress_rules[count.index].from_port
  to_port                  = var.ingress_rules[count.index].to_port
  protocol                 = var.ingress_rules[count.index].protocol
  cidr_blocks              = var.ingress_rules[count.index].cidr_blocks
  security_group_id        = aws_security_group.main.id
  description              = lookup(var.ingress_rules[count.index], "description", null)                                                                        # Pega a descrição se existir
  source_security_group_id = lookup(var.ingress_rules[count.index], "security_groups", null) != null ? var.ingress_rules[count.index].security_groups[0] : null # Suporta apenas um SG por enquanto para simplificar
}

# Egress Rules
resource "aws_security_group_rule" "egress" {
  count                    = length(var.egress_rules)
  type                     = "egress"
  from_port                = var.egress_rules[count.index].from_port
  to_port                  = var.egress_rules[count.index].to_port
  protocol                 = var.egress_rules[count.index].protocol
  cidr_blocks              = var.egress_rules[count.index].cidr_blocks
  security_group_id        = aws_security_group.main.id
  description              = lookup(var.egress_rules[count.index], "description", null) # Get the description if it exists
  source_security_group_id = lookup(var.egress_rules[count.index], "security_groups", null) != null ? var.egress_rules[count.index].security_groups[0] : null
}