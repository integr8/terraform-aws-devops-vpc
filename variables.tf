variable "cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR"
}

variable "subnets" {
  type        = "map"
  description = "Subnets mapping"

  default = {
    public  = ["10.0.1.0/24", "10.0.2.0/24"]
    private = ["10.0.3.0/24", "10.0.4.0/24"]
  }
}

data "aws_availability_zones" "available" {}
