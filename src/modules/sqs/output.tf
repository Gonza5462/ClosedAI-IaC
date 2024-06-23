output "sqs_queue_url" {
  description = "URL de la cola SQS"
  value       = aws_sqs_queue.sqs_queue.url
}

output "sqs_queue_arn" {
  value = aws_sqs_queue.sqs_queue.arn
}