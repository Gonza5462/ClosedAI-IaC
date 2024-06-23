resource "aws_sqs_queue" "sqs_queue" {

  name                        = "cryptosqs"
  delay_seconds               = 10
  visibility_timeout_seconds  = 30
  max_message_size            = 2048
  message_retention_seconds   = 86400
  receive_wait_time_seconds   = 2
}

resource "aws_sqs_queue_policy" "sqs_policy" {
  queue_url = aws_sqs_queue.sqs_queue.url

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "__default_policy_ID",
    Statement = [
      {
        Sid       = "__owner_statement",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::268120344536:root"
        },
        Action   = "SQS:*",
        Resource = "${aws_sqs_queue.sqs_queue.arn}"
      }
    ]
  })
}

