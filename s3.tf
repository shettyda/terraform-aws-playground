resource "aws_s3_bucket" "my_bucket" {

  bucket = "shetty-terra-bucket"

  tags = {
    Name        = "terra-created-bucket"
    Environment = "Dev Lab"
    Owner       = "shettyda"
  }

}
