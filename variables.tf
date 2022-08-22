variable "aws_access_key" {
  type = string
  default = ""
}
variable "aws_secret_key" {
  type = string
  default = ""
}

variable "ssh_key" {
  type    = string
  default = "New-Key"
}

variable "name" {
  type    = string
  default = "Laurentiu"
}

variable "ami_id" {
  type    = string
  default = "ami-0015a39e4b7c0966f"
}