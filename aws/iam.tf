resource "aws_iam_user" "tutorial_iam" {
    name = var.iam_username
}

resource "aws_iam_user_policy" "tutorial_policy" {
    name = "github_actions_policy"
    user = aws_iam_user.tutorial_iam.name

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                "Resource": [
                    aws_s3_bucket.tutorials_site.arn,
                    "${aws_s3_bucket.tutorials_site.arn}/*"
                ],
                "Sid": "BucketEdit",
                "Effect": "Allow",
                "Action": [
                    "s3:*"
                ]
            },
            {
                "Sid": "CloudFrontEdit",
                "Effect": "Allow",
                "Action": "cloudfront:*",
                "Resource": aws_cloudfront_distribution.tutorials_site.arn
            }

        ]
    })
}

resource "aws_iam_access_key" "tutorial" {
    user = aws_iam_user.tutorial_iam.name
}