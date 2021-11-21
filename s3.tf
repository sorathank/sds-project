resource "aws_s3_bucket" "app_s3" {
  bucket = "${var.bucket_name}"
  acl = "private"
  force_destroy = true
  tags = {
    "Name" = "app-s3"
  }
}

resource "aws_iam_user" "app" {
  name = "app"
  path = "/storage/"
}

resource "aws_iam_policy" "s3_policy" {
    name = "app-s3-all-control"
    policy = data.aws_iam_policy_document.policy.json  
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [ "s3:*" ]
    resources = [ aws_s3_bucket.app_s3.arn,"${aws_s3_bucket.app_s3.arn}/*"]
    effect = "Allow"
  }
  statement {
    actions = [
                "kms:Decrypt",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext",
                "kms:GenerateDataKeyPairWithoutPlaintext",
                "kms:GenerateDataKeyPair"
              ]
    resources = ["*"]
    effect = "Allow"
  }
}

resource "aws_iam_user_policy_attachment" "attachment" {
    user = aws_iam_user.app.name
    policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_access_key" "app_key" {
  user = aws_iam_user.app.name
}