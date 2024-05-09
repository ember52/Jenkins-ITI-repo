variable vpc_cidr {
  type        = string
  description = "description"
}

variable common_resource_name {
  type        = string
  default= "Hassan_Test"
  description = "description"
}

variable region {
  type        = string
  description = "description"
}

variable subnets_details {
  type        = list(object({
    name=string,
    cidr=string,
    type=string
    az=string
  }))
  description = "description"
}

