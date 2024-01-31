variable "ssh-user" {
  description = "Type the name of the user that will access the instance through SSH"
  type        = string
}

variable "project-id" {
  description = "Type the Project ID"
  type        = string
}

variable "sa-key-path" {
  description = "Type the path of the service account key"
  type        = string
}

variable "project-region" {
  description = "Type the desired region for the project"
  type        = string
}

variable "project-zone" {
  description = "Type the desired zone for the project"
  type        = string
}
