variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default  =  "us-east-1"
}

variable "AMIS" {
  type      =  map
  default   = {
    us-east-1    =    "ami-0c41531b8d18cc72b"
    us-east-2    =    "ami-078cbc4c2d057c244"
    us-west-1    =    "ami-0fa0ed170a59f4917"

}
}
