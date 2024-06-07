output "queue_url" {
  description = "URL de la cola SQS"
  value       = aws_sqs_queue.sqs_queue.url
}
