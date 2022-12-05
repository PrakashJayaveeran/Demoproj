variable "instance" {
  type    = string
  default = "ami-074dc0a6f6c764218"
}
variable "instancetype" {
  type    = string
  default = "t2.micro"
}

variable "ingressrule" {
  type    = list(number)
  default = [8080, 22]
}
