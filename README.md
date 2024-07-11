# ClosedAI-IaC



MongoDB:
user: admin
Pass: admin
Ver si cambia la IP cuando se corta el lab:    ec2-54-88-69-141.compute-1.amazonaws.com
Port: 27017

Mongo funciona.









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
    Id      = "PolicyForSQS",
    Statement = [
      {
        Sid       = "__owner_statement1",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::268120344536:root"
        },
        Action   = "SQS:*",
        Resource = "${aws_sqs_queue.sqs_queue.arn}"
      },
      {
        Effect = "Allow",
        Action = "SQS:SendMessage",
        Resource = "${aws_sqs_queue.sqs_queue.arn}"
        Condition = {
          ArnEquals = {
              "aws:SourceArn" = "arn:aws:sns:us-east-1:268120344536:criptosnstopic"
          }
        }
      }
    ]
  })
}

