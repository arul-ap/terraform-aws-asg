variable "org" {
  description = "Organization code to inlcude in resource names"
  type        = string
}
variable "proj" {
  description = "Project code to include in resource names"
  type        = string
}
variable "env" {
  description = "Environment code to include in resource names"
  type        = string
}
variable "lt" {
  type = object({
    name          = string
    ami_id        = string
    instance_type = string
  })
}
variable "asg" {
  type = object({
    name         = string
    subnet_id    = list(string)
    lb_tg_arn    = string
    min_size     = number
    max_size     = number
    desired_size = number
  })
}
