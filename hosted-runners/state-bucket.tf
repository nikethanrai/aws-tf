data "aws_caller_identity" "current" {
}

resource "aws_s3_bucket" "tf_state" {
    bucket = "tf-state-${data.aws_caller_identity.current.account_id}-ap-southeast-2"
  
}

resource "aws_s3_bucket_versioning" "tf_state" {
    bucket = aws_s3_bucket.tf_state.id
    versioning_configuration {
      status = "Enabled"
    }
  
}