variable "name" {
  description = "Name of the Security Group."
  type        = string
}

variable "description" {
  description = "Description of the Security Group."
  type        = string
  default     = "Security Group created by Terraform."
}

variable "vpc_id" {
  description = "VPC ID where the Security Group will be created."
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules."
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = optional(list(string), []) # Optional list of security groups to support multiple SGs
    description     = optional(string, null)
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules."
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups = optional(list(string), []) # Optional list of security groups to support multiple SGs
    description     = optional(string, null)
  }))
  default = [ # Default: allow all outbound traffic
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    }
  ]
}

variable "tags" {
  description = "Tags to be applied to the Security Group."
  type        = map(string)
  default     = {}
}