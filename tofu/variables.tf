variable "ssh-user" {
  description = "Type the name of the user that will access the instance through SSH"
  type        = string
}

variable "labs-vpc" {
  description = "Chosen network for the project"
  type        = string
}

variable "labs-subnet" {
  description = "Chosen subnet for the project"
  type        = string
}
