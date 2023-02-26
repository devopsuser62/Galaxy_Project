terraform {
  backend "s3" {
    bucket  =  "terraform-el-xander"
    key     =  "terraform/xander"
    region  =  "ca-central-1"
}
}
