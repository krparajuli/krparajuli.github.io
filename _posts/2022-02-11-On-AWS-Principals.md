---
layout: post
title:  "Summary: \"Principal\" in AWS IAM Policies"
date:   2022-02-05 21:03:36 -0500
categories: AWS IAM Principal Security Identity-Access Summary
---

`Principal` is a Resource-based policy element in AWS to specify whether an entity is allowed or denied access to a resource. This means that it can be a part of the policy of a resource like S3 or RDS but not of entities like users, groups, etc. Likewise, in IAM roles, `Principal` element tells who can assume the role and who cannot.

### How to use it
You can specify the a pringiple Amazon Resource Name (ARN) in the `aws:PrincipalArn` condition key.

In cross-account access, the 12-digit identidier of the trusted account must be specified (as shown below). You can specify principal using identifiers or canonical user identifier.
```JSON
"Principal": { 
  "AWS": [
    "arn:aws:iam::123456789012:root", //Cross-Account OR Fully Descriptive Identifer
    "999999999999" // Condensed Identifier for Same-account access
  ],
  "CanonicalUser": "79a59df900b949e55d96a1e698fbacedfd6e09d98eacf8f8d5218e7cd47ef2be" //Canonical Identifier
}
```

### IAM Role Principals
**Role Session Principal**:
You can specify role sessions in the Principal element of a resource-based policy or in condition keys that support principals. When a principal or identity assumes a role, they receive temporary security credentials with the assumed role’s permissions. When they use those session credentials to perform operations in AWS, they become a `role session principal`.

Additionally, administrators can design a process to control how role sessions are issued like `predictable session name`.

#### Assumed-role session principals
An assumed-role session principal is a session principal that results from using the AWS STS AssumeRole operation.
```JSON
"Principal": { "AWS": "arn:aws:sts::AWS-account-ID:assumed-role/role-name/role-session-name" }
```

#### Web identity session principals
A web identity session principal is a session principal that results from using the AWS STS AssumeRoleWithWebIdentity operation.
```JSON
"Principal": { "Federated": "cognito-identity.amazonaws.com" }
```
```JSON
"Principal": { "Federated": "accounts.google.com" }
```

#### SAML session principals

A SAML session principal is a session principal that results from using the AWS STS AssumeRoleWithSAML operation.
```JSON
"Principal": { "Federated": "arn:aws:iam::AWS-account-ID:saml-provider/provider-name" }
```

#### IAM user principals
You can specify IAM user sin the Principal element of a resource-based policy or in condition keys that support principals.
```JSON
"Principal": {
  "AWS": [
    "arn:aws:iam::AWS-account-ID:user/user-name-1",  //user-name part is case sensitive
    "arn:aws:iam::AWS-account-ID:user/user-name-2"
  ]
}
```

#### AWS STS federated user session principals
An AWS STS federated user session principal is a session principal that results from using the AWS STS GetFederationToken operation.
* Federated Root User
* IAM Federated User
```JSON
"Principal": { "AWS": "arn:aws:sts::AWS-account-ID:federated-user/user-name" }
```
### AWS service principals
You can specify AWS services in the Principal element of a resource-based policy or in condition keys that support principals. A service principal is an identifier for a service.

IAM roles that can be assumed by an AWS service are called service roles. Service roles must include a trust policy. Trust policies are resource-based policies attached to a role that defines which principals can assume the role. Some service roles have predefined trust policies. However, in some cases, you must specify the service principal in the trust policy.
```JSON
"Principal": {
    "Service": [
        "ecs.amazonaws.com",
        "elasticloadbalancing.amazonaws.com"
   ]
}
```

#### All principals
They are principal that use wildcards. It means all users.
```JSON
"Principal": "*"
```
```JSON
"Principal" : { "AWS" : "*" }
```


A sample Policy with SQS action and Conditions.
```JSON
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {"AWS": "111122223333"},
    "Action": [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ],
    "Resource": ["arn:aws:sqs:*:123456789012:queue1"],
    "Condition": {
      "DateGreaterThan": {"aws:CurrentTime": "2014-11-30T12:00Z"},
      "DateLessThan": {"aws:CurrentTime": "2014-11-30T15:00Z"}
    }
  }
}
```

## Reference
*[AWS JSON policy elements: Principal (https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html)*
*[ (https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_policy-examples.html)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_policy-examples.html)