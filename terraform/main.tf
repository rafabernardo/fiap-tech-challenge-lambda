resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.lambda_bucket_name
  force_destroy = true
}

resource "aws_s3_object" "lambda_layer_zip" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "layers"
  acl    = "private"
  source = "../layer.zip"
}

resource "aws_s3_object" "lambda_function_zip" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "functions"
  acl    = "private"
  source = "../function.zip"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name          = "lambda-layer"
  compatible_runtimes = ["python3.9"]
  s3_bucket           = aws_s3_bucket.lambda_bucket.bucket
  s3_key              = aws_s3_object.lambda_layer_zip.key
}
resource "aws_lambda_function" "lambda" {
  function_name = "lambda-function"
  handler       = "index.handler"
  runtime       = "python3.9"
  role          = data.aws_iam_role.name.arn

  layers = [aws_lambda_layer_version.lambda_layer.arn]

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_function_zip.key

  depends_on = [aws_s3_object.lambda_layer_zip]
}

