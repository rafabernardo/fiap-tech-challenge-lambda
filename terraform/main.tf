resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.lambda_bucket_name
}

resource "aws_s3_object" "lambda_layer" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "layers/dependencies-layer.zip"
  acl    = "private"
}

resource "aws_s3_object" "lambda_function" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "functions/lambda-function.zip"
  acl    = "private"
}
