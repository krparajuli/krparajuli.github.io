---
layout: post
title:  "Accessing a public amazon S3 bucket using AWS CLI"
author: Kalyan Parajuli
date:   2021-02-07 18:00:00 -0500
categories: AWS Amazon S3 Bucket CLI
comments: true
---


AWS CLI (with its recently released version 2, at the time of writing) is a powerful tool to access and manage AWS resources. One can manage their own AWS platform or public AWS resources like AWS S3 buckets.

AWS S3 buckets are simple block storage units in AWS that can either be private or public. Pre-signed URLs can give temporary access to the private buckets - however public buckets are free to access for all logged in users. S3 bucket names are globally unique - meaning two different origanizations cannot have buckets with the same name (say `sample`). Since the bucket names are globally unique (be it public or private), it is easy to reach a particular bucket once you know its identifying name and the file contained inside it. 

*In order to access the buckets (private or public), you ought to be using AWS CLI as a signed in user. Using the browser and the S3 REST API might not always work due to `listPermission` and other permissions set in the bucket.* Following are the instructions to do so.

# Contents
  - [Create an AWS Account](#create-an-aws-account)
  - [Install AWS CLI](#install-aws-cli)
  - [Log into AWS CLI using AWS key](#log-into-aws-cli-using-aws-key)
  - [Access and Download public S3 contents](#access-and-download-public-s3-contents)


### Create an AWS Account
You can create an AWS account by going to [Amazon AWS](https://aws.amazon.com/). Every new AWS account gives you access to a year of free-tier services for free. The free-tier offers some basic but useful services like EC2 computer instance and S3 storage. However, it requires credit card and payment information in order to complete the signup.

Once successfully creating your account, log into your AWS console. Then, click on the `username` on the top left of the console window. Then, go to `My Security Credentials`.

Click on the `Access Keys` dropdown and create your first access key using `Create New Access Key` button. This will create key pair (Access Key and Secret Key) and will prompt you to download the file. Be careful as the secret key won't be displayed on dashboard ever again. However, you can always create a new key pair and use it to log in to CLI.

*It is important to get the access keys to log into the AWS CLI. Remember, you have to be logged in to access public S3 buckets.*

### Install AWS CLI
You can install your AWS CLI by going to the official [AWS CLI V2 download page](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) and clicking the machine OS you are working with. You will also get instructions 

After installing it on your system, go to your machine shell and type `aws --version` to confirm everything is running smoothly.

### Log into AWS CLI using AWS key

You can then login using aws configure. Use the `Access Key` and `Secret Key` from the key pair gotten from the steps above. For region name, you can leave it to be default or chose your region if you know it (example `us-east-1`). The output format can also be left blank.

Now the machine is all configured to do AWS magic.

### Access and Download public S3 contents
Now you can use `aws s3api` module to get the file you want. The command to use is `get-object`.

Here is an example you can try.
```
aws s3api get-object --bucket assets.hackycorp.com --key key2.txt output.txt
```
This file, however, is found to be inaccessible using its
[S3 REST API (https://s3.console.aws.amazon.com/s3/object/assets.hackycorp.com/key2.txt)](https://s3.console.aws.amazon.com/s3/object/assets.hackycorp.com/key2.txt)






