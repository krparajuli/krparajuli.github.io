---
layout: post
title:  "AWS IAM Quick Review"
date:   2021-01-23 21:03:36 -0500
categories: AWS IAM IaC
---
# AWS IAM
[https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

## USERS AND GROUPS
* Max 5000 users per organization/account
* Max 10 groups per user
* Are Global within organization/account ID
* `DENY` trumps any `allow`
> EXAMPLE
 
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowServices",
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "cloudwatch:*",
                "ec2:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowIAMConsoleForCredentials",
            "Effect": "Allow",
            "Action": [
                "iam:ListUsers",
                "iam:GetAccountPasswordPolicy"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowManageOwnPasswordAndAccessKeys",
            "Effect": "Allow",
            "Action": [
                "iam:*AccessKey*",
                "iam:ChangePassword",
                "iam:GetUser",
                "iam:*LoginProfile*"
            ],
            "Resource": ["arn:aws:iam::*:user/${aws:username}"]
        },
        {
            "Sid": "DenyS3Logs",
            "Effect": "Deny",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::logs",
                "arn:aws:s3:::logs/*"
            ]
        },
        {
            "Sid": "DenyEC2Production",
            "Effect": "Deny",
            "Action": "ec2:*",
            "Resource": "arn:aws:ec2:*:*:instance/i-1234567890abcdef0"
        }
    ]
}
```

## POLICY
* VERSION; Sid; EFFECT; ACTION; RESOURCE; PRINCIPAL; CONDITION
  * Wildcards can be used for latter 3
  * ACTION is case insensitive; Rest are Sensitive
* User based Policy = Cannot have Principal Element
* Resource based Policy = Has **Principal** (User/Group) Element
* **CONDITION**
  *  StringEqual for aws:username, aws:principaltype, etc.
  *  DateGreaterThan, etc.
  *  Same clause must be grouped together
  *  Can use for access to certain tags only
```json {
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": [
            "iam:TagUser",
            "iam:TagRole",
            "iam:UntagUser",
            "iam:UntagRole"

        ],
        "Resource": "*",
        "Condition": {"ForAllValues:StringEquals": {"aws:TagKeys": "Department"}}
    }
}
```

## ROLE
* Most Useful IAM feature
* Based on Employee Roles
* Use `sts:AssumeRole`
  * Allows for multi account access roles as roles have account id included in the policy
  * NOTICE `111111111111` account ID in sample policy below
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject*",
                "s3:PutObject*",
                "s3:ReplicateObject",
                "s3:RestoreObject"
            ],
            "Principal": { "AWS": "arn:aws:iam::111111111111:user/carlossalazar" },
            "Resource": "arn:aws:s3:::Production/*"
        }
    ]
}
```
* Has access to resource to allow roles
* Can only assume one role at once
* While Assuming a role, will gain all access provided by the role
  * But forfeits all accesses not included
* Create separate policy for assuming different role for security
* `EXTERNAL ID` can be required


