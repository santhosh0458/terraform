locals {
  bucketname = "my-tf-test-bucket-227766"
}


data "archive_file" "init" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function.zip"
}

//resource "aws_s3_bucket_notification" "bucket_notification" {
//  bucket = local.bucketname
//
//  lambda_function {
//    lambda_function_arn = lambda_function.arn
//    events              = ["s3:ObjectCreated:*"]
//  }
//}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "sts:AssumeRole",
          "s3:*",
          "dynamodb:*"
        ],
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

//event = {
//    type          = "s3"
//    s3_bucket_arn = "arn:aws:s3:::my-tf-test-bucket-227766"
//    s3_bucket_id  = local.bucketname
//}

resource "aws_lambda_function" "lambda_function" {
  filename      = "lambda_function.zip"
  function_name = "lambda_function"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function"
  source_code_hash = filebase64sha256("lambda_function.zip")
  runtime = "python3.8"
}

//module "lambda" {
//  source           = "../../"
//  description      = "Example AWS Lambda using go with S3 trigger"
//  filename         = "lambda_function.zip"
//  function_name    = "lambda_function"
//  handler          = "lambda_handler"
//  runtime          = "python3.8"
//  source_code_hash = filebase64sha256("lambda_function.zip")
//
//  event = {
//    type          = "s3"
//    s3_bucket_arn = "arn:aws:s3:::my-tf-test-bucket-227766"
//    s3_bucket_id  = local.bucketname
//  }
//
//}

