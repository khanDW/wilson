terraform {
  backend "s3" {
    bucket         = "samsbucket-bucket-state"
    key            = "ec2.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraformstatelock"
  }
}