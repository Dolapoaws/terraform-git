variable "ami" {
  type = map
  default = {
    rhel = "ami-018d291ca9ffc002f"
    linux = "ami-0c2ab3b8efb09f272"
    ubuntu = "ami-05fa00d4c63e32376"
  }
}

variable "instance_type" {
  type = list
  default = ["t2.micro", "t2.small", "t2.medium"]
}

variable "profile" {

}

variable "region" {

}
