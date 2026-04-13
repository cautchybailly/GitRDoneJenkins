
resource "aws_s3_bucket" "Class7_gutcheck_bucket" {
  bucket = "class7-gutcheck-bucket"
  acl    = "private"

  tags = {
    Name = "class7-gutcheck-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "class7-gcheck" {
  bucket = aws_s3_bucket.class7_gutcheck_bucket.id

  block_public_acls  = true
  ignore_public_acls = true

  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "class7_gut_check" {
  bucket = aws_s3_bucket.class7_gutcheck_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicAccess"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.class7_gutcheck_bucket.arn}/*"
      }
    ]
  })
}

### Object to be uploaded

resource "aws_s3_object" "screenshots" {
  for_each = fileset("../Screenshots", "**/*")

  bucket = aws_s3_bucket.class7_gutcheck_bucket.id
  key    = "Artifacts/${each.value}"
  source = "../Screenshots/${each.value}"
  etag   = filemd5("../Screenshots/${each.value}")
}

resource "aws_s3_object" "TKO-armageddon-link" {
  bucket = aws_s3_bucket.class7_gutcheck_bucket.id
  key    = "Artifacts/TKO-armageddon-link.md"
  source = "../TKO-armageddon-link.md"
  etag   = filemd5("../TKO-armageddon-link.md")
}