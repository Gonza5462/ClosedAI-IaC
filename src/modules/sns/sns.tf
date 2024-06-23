resource "aws_sns_topic" "sns_topic" {
  name = "criptosnstopic"
}

resource "aws_sns_topic_policy" "sns_policy" {
  arn = aws_sns_topic.sns_topic.arn

  policy = jsonencode({
    Version = "2008-10-17",
    Id      = "CriptoPolicy",
    Statement = [
      {
        Sid       = "AllowCriptoToAll",
        Effect    = "Allow",
        Principal = {
          AWS = "*"
        },
        Action   = [
          "SNS:Publish",
          "SNS:RemovePermission",
          "SNS:SetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:AddPermission",
          "SNS:Subscribe"
        ],
        Resource = "${aws_sns_topic.sns_topic.arn}"
      },
      {
        Sid       = "AllowEveryoneToSuscribe",
        Effect    = "Allow",
        Principal = {
          AWS = "*"
        },
        Action   = "SNS:Subscribe",
        Resource = "${aws_sns_topic.sns_topic.arn}"
      }
    ]
  })
}

resource "aws_sns_topic_subscription" "sqs_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "sqs"
  endpoint  = var.sqs_queue_arn
}