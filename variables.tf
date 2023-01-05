variable "namespace" {
  description = "namespace to uniquely name resource"
  type        = string
}


variable "key_pair" {
  description = "SSH kay pair to use with EC2 instances"
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region fro infra deployment"
  type        = string
  default     = "us-east-1"

}