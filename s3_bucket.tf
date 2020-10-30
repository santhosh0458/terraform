resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-227766"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = "my-tf-test-bucket-227766"
  key    = "list.csv"
  source = "list.csv"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("list.csv")
}