terraform {
  backend "s3" {
    bucket = "terraformlab-x-el-xander"
    key    = "terraform/xander"
    region = "ca-central-1"
  }
}
