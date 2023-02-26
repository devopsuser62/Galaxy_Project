#Kubernetes Master Role and Policy

resource "aws_iam_role" "k8s-master" {
  name = "k8s-master"
  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
     }
   ]
})
}

resource "aws_iam_instance_profile" "k8s-master-instanceprofile" {
  name = "k8-master"
  role = "${aws_iam_role.k8s-master.name}"
}

resource "aws_iam_role_policy" "k8s-master-policy" {
  name = "k8s-master-policy"
  role = "${aws_iam_role.k8s-master.id}"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:*",
                "elasticloadbalancing:*",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:BatchGetImage",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:UpdateAutoScalingGroup"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}

#Kubernetes Worker Role and Policy

resource "aws_iam_role" "k8s-worker" {
  name = "k8s-worker"
  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
     }
   ]
})
}

resource "aws_iam_instance_profile" "k8s-worker-instanceprofile" {
  name = "k8-worker"
  role = "${aws_iam_role.k8s-worker.name}"
}

resource "aws_iam_role_policy" "k8s-worker-policy" {
  name = "k8s-worker-policy"
  role = "${aws_iam_role.k8s-worker.id}"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:Describe*",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:BatchGetImage"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
})
}

