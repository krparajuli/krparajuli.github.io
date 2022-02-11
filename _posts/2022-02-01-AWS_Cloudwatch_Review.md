---
layout: post
title:  "AWS Cloudwatch Review"
date:   2021-02-01 21:03:36 -0500
categories: AWS IaC CloudWatch
---

> ### Brief Explanation of Amazon Config
> AWS Config is a fully managed service that provides you with an inventory of your AWS resources, configuration history, and configuration change notifications to enable security and governance. Notifications are provided via Amazon's simple notification service. With AWS Config, you can discover existing AWS resources, export a complete inventory of your AWS resources, with all configuration details, determine how a resource was configured at any point in time, get notified when resources are created, modified, or deleted, view relationships between resources. For example, how many EC2 instances use a specific security group. This enables compliance auditing, security analysis, resource change tracking, and troubleshooting.
> ### Brief Explanation of Elastic Beanstalk
> Elastic Beanstalk allows you to quickly deploy and manage applications within the AWS cloud, without having to configure the infrastructure that runs those applications. Deploying is as simple as uploading the application and Elastic Beanstalk automatically handles capacity provisioning, load balancing and application health monitoring. 

This review is based on the LinkedIn Learning course [AWS Monitoring and Reporting](https://www.linkedin.com/learning/aws-monitoring-and-reporting) by Shyam Raj.


* Monitor Resources
* Create alarms to watch metrics
* Create custom dashboards
* Send notificatoins or make changes to resources
* Metrics collected by Cloudwatch cannot be deleted; They expired after 15 months if no data is published to them

### Terminology
* Namespace - container for Cloudwatch metrics
* Metrics - Variable associated with applications and services
  * must be associated with timestamp, **dateTime** Objects

### Integration
* IAM - specify perms to access Cloudwatch
* IAM cannot be used Cloudwatch for specific resources
  * Covers all details of Cloudwatch resourcse
  
### Billing Alarms
* Can be used to monitor AWS charges
* Create Billing Alarm; Create Billing Alerts
* Billing data is stored in US East (N. VA.)

### Amazon SNS (Simple Notification Service)
* Message Delivery to Subscribing endpoints
* Publisher Clients and Subscriber Clients
* Create SNS Topic and Create Permissions to Publisher and Subscribers
*  The supported protocols are HTTP/S, Email, SMS, AWS Lambda, and Amazon SQS. 

### CPU Alarms
* AutoScale
* Or Investigate

### Load Balancers
* Monitor in CloudWatch using status checks 
* Can monitor Latency
  
### EBS Storage
* Monitoring the health of EBS volumes
* Ensure that EC2 instances are working properly
* EC2 instances have handling load and proper configuration
* Metrics
  * VolumeReadOps,WriteOps
  * VolumeReadBytes,WriteBytes
  * VolumeIdleTime
  * VolumeBurstBalance

# Custom Metrics
* Metrics not natively supported by Cloudwatch
  * Because CloudWatch only has access to metrics visibility to hypervisor
* Metrics example
  * Memory Utilization
  * Page load times
  * **Number of processes running**
  * Number of users logged in
  * Number of TCP connections
* Need to install CloudAgent on your system
  
## Montoring beyond CloudWatch  
### RDS Instances
* Network throughput, Number of client connections, I/O for Read write Operations
* ESTABLISH BASESLINE
  * STORE HISTORICAL MONITORING DATA
  * Involve DB and other admins for other real world data for baseling
* Use RDS events and log files
  * Availability
  * Backup
  * Configuration Changes
  * Creation and Deletion
  * Failure
  * Failover
  * Low Stroage
  
### SQS (Simple Queue Services)
* SQS supports standard and FIFO queues
* Number of mess
* Detailed Metrics not available for SQL
* Examples:
  * \# of messages sent/revd
  * Sent message size
  * Age of oldest messages

### SNS
* View and analyze metrics for SNS notifications
* Dimensions for filtering SNS
  * Application
  * Platform
  * Application, platform
  * Country
  * SMS type
  * TopicName
  
### Elastic Beanstalk
* Elastic Beanstalk allows you to quickly deploy and manage applications within the AWS cloud, without having to configure the infrastructure that runs those applications. Deploying is as simple as uploading the application and Elastic Beanstalk automatically handles capacity provisioning, load balancing and application health monitoring. 
* Monitor has color based on number of health check fails
  
# AWS Config
* AWS Config is a fully managed service that provides you with an inventory of your AWS resources, configuration history, and configuration change notifications to enable security and governance. Notifications are provided via Amazon's simple notification service. With AWS Config, you can discover existing AWS resources, export a complete inventory of your AWS resources, with all configuration details, determine how a resource was configured at any point in time, get notified when resources are created, modified, or deleted, view relationships between resources. For example, how many EC2 instances use a specific security group. This enables compliance auditing, security analysis, resource change tracking, and troubleshooting
* Uses DescribeAPI call to query and sotre configuration
*  AWS Config configuration items can be delivered to an Amazon S3 bucket or an Amazon SNS topic.
### AWS Config Components
* Configuration item - Point-in-time view of the attributes of a resource
* Configuration history - collection of configuration items
* Configuration recorder - stores configuration
* Configuration rules - desired configuration setting

## AWS Config Rules
* Set of rules that are default or compliant for different resources
* Helps check `safety` and `compliance`
* Each custom AWS Config rule must be associated with an AWS Lambda function. It contains the logic to check whether your resources comply with the rule.
* It will mark any rules as non-compliant if does not match the rules
### Managed Rules
* Rules predefined by AWS
### Custom Rules
* Custom Rules created by requirements of an entity

# CloudWatch Events
* Track Operation change
* Responds to change
* Can Trigger predetermined actions
* CloudWatch Events can be configured with rules that trigger automatically at predetermined schedules.

