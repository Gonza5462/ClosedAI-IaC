resource "aws_sqs_queue" "sqs_queue" {

  name                        = "Crypto-FIFO-SQS"
  fifo_queue                  = true
  content_based_deduplication = true
  delay_seconds               = 10
  visibility_timeout_seconds  = 30
  max_message_size            = 2048
  message_retention_seconds   = 86400
  receive_wait_time_seconds   = 2
}
