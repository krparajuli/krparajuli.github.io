---
layout: post
title:  "AWS IAM Quick Review"
date:   2021-01-23 21:03:36 -0500
categories: AWS IAM IaC
---
All details and code taken from [AWS IAM documentation page](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html). You can  test all your IAM policies usin [IAM Policy Simulator](https://policysim.aws.amazon.com/).

## USERS AND GROUPS
* Max 5000 users per organization/account
* Max 10 groups per user
* Are Global within organization/account ID
* `DENY` trumps any `allow`
 
```json
// Example
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

## AWS ORGANIZATION
* Different for IAM
* Helps manage and group accounts within an organization in Organizational Units (OU) using *Service Control Policy*
* *DENY SOME* and *ALLOW ALL ELSE* policies makes more sense - since an account may need ton of accesses that needs to be allowed
* AWS Organization can control *root* of other accounts

## POLICY EVALUATION LOGIC
Following is the order of evaluation of AWS Policy Logic.
1. Start with Deny
2. Gather all application policies and Evaluate. DENY if there is EXPLICIT DENY.
3. Check for Organizational SCP (Service Control Policy). DENY if there is NO EXPLICIT ALLOW.
4. Check for Resource based policy. ALLOW if there is ALLOW.
5. Check for principal based policy. DENY if NO POLICY or NO EXPLICIT ALLOW.
6. Check for permission boundary.
7. Check for sessions and sessions policy.

Refer to the chart below.

![AWS Policy Evluation Chart](https://docs.aws.amazon.com/IAM/latest/UserGuide/images/PolicyEvaluationHorizontal111621.png) The policy evaluation page has more details. 

Have fun architecting!!!
