terraform {
  backend "s3" {
    bucket = "dev-proj-1-jenkins-remote-state-bucket-2708"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}