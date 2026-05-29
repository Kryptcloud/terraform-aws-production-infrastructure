# terraform-aws-production-infrastructure
# Production Infrastructure Foundation on AWS

## Terraform-Based Highly Available AWS Architecture with CI/CD Automation

![ Diagram](./Terraform High Availability architecture.png)

---

# Overview

This project demonstrates the design and deployment of a production-style AWS infrastructure using Terraform, modular Infrastructure as Code principles, remote state management, and automated CI/CD pipelines powered by GitHub Actions and a self-hosted runner.

The infrastructure is designed with high availability, scalability, automation, and security best practices in mind. It simulates a real-world cloud infrastructure foundation capable of hosting scalable applications in a multi-subnet AWS environment.

The project includes:

* Modular Terraform architecture
* Multi-subnet VPC design
* Public and private subnet separation
* Internet Gateway and NAT Gateway configuration
* Route table segmentation
* Application Load Balancer (ALB)
* Auto Scaling Group (ASG)
* EC2 infrastructure deployment
* Security group segmentation
* Remote Terraform backend using S3
* Terraform state locking
* GitHub Actions CI/CD automation
* Self-hosted GitHub Actions runner on EC2

---

# Project Objectives

The primary goals of this project are:

* Build reusable Infrastructure as Code using Terraform modules
* Simulate production-grade AWS networking architecture
* Implement scalable and highly available infrastructure
* Automate infrastructure deployment using CI/CD pipelines
* Demonstrate remote Terraform state management
* Implement secure infrastructure provisioning workflows
* Gain hands-on DevOps and cloud engineering experience

---

# Architecture Summary

The infrastructure consists of:

## Networking Layer

* Custom VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* NAT Gateways
* Public and Private Route Tables

## Compute Layer

* EC2 instances deployed in private subnets
* Auto Scaling Group for scalability and resilience
* Launch Template for instance provisioning

## Traffic Layer

* Application Load Balancer (ALB)
* Target Groups
* Listener configuration

## Security Layer

* Dedicated security groups
* Controlled inbound and outbound traffic
* Private subnet isolation

## Terraform Backend

* Remote Terraform state stored in S3
* Terraform state locking enabled

## CI/CD Layer

* GitHub Actions workflow automation
* Self-hosted runner deployed on EC2
* Automated Terraform validate, plan, and apply pipeline

---

# Technologies Used

 Technology          Purpose                             

 Terraform           Infrastructure as Code              
 AWS VPC             Network isolation                   
 AWS EC2             Compute resources                   
 AWS Auto Scaling    Elastic infrastructure              
 AWS ALB             Traffic distribution                
 AWS NAT Gateway     Private subnet internet access      
 AWS S3              Terraform remote backend            
 GitHub Actions      CI/CD automation                    
 Self-Hosted Runner  Infrastructure deployment execution 
 Linux (Ubuntu)      Runner operating system             

---

# Infrastructure Components

## VPC

A custom VPC was created to isolate and manage all infrastructure resources within a dedicated network boundary.

### CIDR Block

```hcl
10.0.0.0/16
```

---

## Public Subnets

Public subnets host:

* NAT Gateways
* Load Balancer
* Public-facing resources

### Public Subnets

* 10.0.1.0/24
* 10.0.2.0/24

---

## Private Subnets

Private subnets host backend compute resources.

### Private Subnets

* 10.0.3.0/24
* 10.0.4.0/24

EC2 instances inside private subnets are not directly accessible from the internet.

---

## Internet Gateway

The Internet Gateway enables internet access for public subnet resources such as:

* Application Load Balancer
* NAT Gateway

---

## NAT Gateway

The NAT Gateway enables outbound internet connectivity for resources inside private subnets while keeping them isolated from inbound public traffic.

---

## Route Tables

Separate route tables were configured for:

### Public Route Tables

* Route internet traffic through the Internet Gateway

### Private Route Tables

* Route outbound traffic through the NAT Gateway

---

## Security Groups

Dedicated security groups were configured to control traffic flow between components.

### Load Balancer Security Group

Allows:

* HTTP traffic
* HTTPS traffic

### Application Security Group

Allows:

* Internal traffic from ALB
* Controlled application communication

---

## Application Load Balancer

The ALB distributes traffic across EC2 instances running in private subnets.

Features:

* High availability
* Traffic distribution
* Fault tolerance
* Scalable request handling

---

## Auto Scaling Group

The Auto Scaling Group automatically manages EC2 instance scaling and availability.

### Configuration

* Multi-AZ deployment
* Desired capacity: 2
* Launch Template integration

Benefits:

* High availability
* Fault tolerance
* Elastic scaling

---

# Terraform Backend Configuration

Terraform remote backend was configured using:

* AWS S3 Bucket for remote state storage
* Terraform state locking enabled

This prevents:

* State corruption
* Concurrent infrastructure modifications
* Unsafe deployments

---

# CI/CD Pipeline

GitHub Actions was integrated to automate infrastructure deployment workflows.

## Pipeline Stages

### 1. Checkout Code

Retrieves the Terraform configuration from GitHub.

### 2. Terraform Initialization

Initializes providers, modules, and backend configuration.

### 3. Terraform Validation

Validates Terraform syntax and configuration.

### 4. Terraform Plan

Generates infrastructure execution plans.

### 5. Terraform Apply

Automatically provisions infrastructure resources.

---

# Self-Hosted GitHub Runner

A self-hosted GitHub Actions runner was deployed on an Ubuntu EC2 instance.

This runner executes:

* Terraform commands
* Infrastructure deployments
* Automated CI/CD workflows

Benefits:

* Full environment control
* Persistent tooling
* Custom deployment environment

---

# Key DevOps Concepts Demonstrated

* Infrastructure as Code (IaC)
* Terraform modules
* Remote state management
* CI/CD automation
* Self-hosted runners
* High availability architecture
* AWS networking
* Infrastructure scalability
* Security segmentation
* GitOps workflow principles

---

# Challenges Encountered

## Troubleshooting & Lessons Learned

During the deployment and automation of this AWS production infrastructure project, several real-world issues were encountered and resolved. These challenges provided deeper understanding of Terraform state management, GitHub Actions self-hosted runners, AWS limitations, and infrastructure debugging.

---

### 1. GitHub Actions Failed During Terraform Setup

#### Error

```bash
Unable to locate executable file: unzip
```

#### Cause

The self-hosted GitHub Actions runner did not have the `unzip` package installed, which is required by the Terraform setup action.

#### Resolution

Installed `unzip` on the EC2 runner instance:

```bash
sudo apt update
sudo apt install unzip -y
```

Verified installation:

```bash
unzip -v
```

---

### 2. Terraform Init Failed Due to Wrong Working Directory

#### Error

```bash
No such file or directory
```

#### Cause

The GitHub Actions workflow referenced an incorrect Terraform working directory path.

#### Resolution

Updated the workflow configuration to point to the correct repository root:

```yaml
working-directory: ./
```

instead of:

```yaml
working-directory: ./terraform-aws-production-infrastructure
```

---

### 3. Terraform Backend Configuration Error

#### Error

```bash
Unsupported argument: use_lockfile
```

#### Cause

The Terraform version being used did not support the `use_lockfile` argument inside the S3 backend configuration.

#### Resolution

Removed the unsupported argument from `backend.tf`.

Correct configuration:

```hcl
terraform {
  backend "s3" {
    bucket  = "terraform-prod-state-bucket"
    key     = "prod/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}
```

---

### 4. AWS Credentials Not Detected

#### Error

```bash
No valid credential sources found
```

#### Cause

AWS credentials were not configured properly on the self-hosted runner.

#### Resolution

Installed AWS CLI and configured credentials manually:

```bash
aws configure
```

Validated credentials:

```bash
aws sts get-caller-identity
```

GitHub repository secrets were also configured for CI/CD authentication.

---

### 5. GitHub Runner Went Offline

#### Issue

GitHub Actions jobs remained queued indefinitely.

#### Cause

The self-hosted EC2 runner service had stopped running.

#### Resolution

Restarted the runner service on the EC2 instance:

```bash
cd ~/gitrunner
./run.sh
```

The runner immediately reconnected and workflow execution resumed.

---

### 6. Terraform State Lock Errors

#### Error

```bash
Error acquiring the state lock
```

#### Cause

A previous Terraform process crashed or was interrupted, leaving the remote state locked in S3.

#### Resolution

Used Terraform force unlock:

```bash
terraform force-unlock LOCK_ID
```

This restored access to the remote state safely.

---

### 7. Duplicate AWS Resources Created

#### Issue

Terraform attempted to recreate infrastructure resources, including additional EC2 instances and networking components.

#### Cause

State inconsistencies occurred after interrupted Terraform operations and backend migration.

#### Resolution

Destroyed orphaned infrastructure resources and reinitialized the Terraform backend:

```bash
terraform destroy -auto-approve
terraform init
```

Infrastructure state was synchronized before redeployment.

---

### 8. Terraform Variable File Not Found

#### Error

```bash
terraform.tfvars does not exist
```

#### Cause

The `terraform.tfvars` file was excluded via `.gitignore`, preventing GitHub Actions from accessing required variable definitions.

#### Resolution

Created a production variable file committed to the repository:

```bash
prod.tfvars
```

Workflow updated to use:

```bash
terraform plan -var-file="prod.tfvars"
```

Sensitive files remained excluded from version control.

---

### 9. Terraform Output Count Error

#### Error

```bash
Reference to "count" in non-counted context
```

#### Cause

`count.index` was used inside an output block where no `count` argument existed.

#### Resolution

Replaced:

```hcl
aws_instance.app[count.index].id
```

with:

```hcl
aws_instance.app[*].id
```

This correctly outputs all instance IDs as a list.

---

### 10. Auto Scaling Group vCPU Limit Exceeded

#### Error

```bash
You have requested more vCPU capacity than your current vCPU limit allows
```

#### Cause

The AWS account exceeded the allowed regional vCPU quota for the selected EC2 instance type.

#### Resolution

Reduced desired capacity and instance count to fit within AWS Free Tier and regional quota limitations.

Example adjustment:

```hcl
desired_capacity = 2
```

instead of larger scaling values.

---

### 11. Terraform Destroy Failed Due to DNS Resolution

#### Error

```bash
lookup elasticloadbalancing.eu-north-1.amazonaws.com: no such host
```

#### Cause

Temporary DNS/network resolution issue while deleting the Load Balancer target group.

#### Resolution

Re-ran the destroy operation after network connectivity stabilized:

```bash
terraform destroy -auto-approve
```

Remaining resources were successfully removed.

---

### 12. Node.js 20 Deprecation Warnings in GitHub Actions

#### Warning

```bash
Node.js 20 actions are deprecated
```

#### Cause

Some GitHub Actions used older Node.js runtime versions.

#### Resolution

Updated workflow actions to the latest supported versions and prepared workflows for Node.js 24 compatibility.

Example:

```yaml
uses: actions/checkout@v4
uses: hashicorp/setup-terraform@v3
```

---

## Key Lessons Learned

* Importance of Terraform remote state management
* Safe handling of infrastructure locks
* Debugging self-hosted GitHub Actions runners
* Managing AWS quotas and scaling limits
* Preventing state drift in Terraform
* Structuring reusable Terraform modules
* CI/CD automation for Infrastructure as Code
* Production-grade infrastructure troubleshooting

These challenges significantly improved practical DevOps troubleshooting skills and provided hands-on experience with real production deployment scenarios.


These troubleshooting experiences strengthened practical DevOps and cloud engineering skills.

---

# Lessons Learned

This project provided hands-on experience in:

* Designing scalable AWS infrastructure
* Building modular Terraform configurations
* Managing Terraform remote state
* Debugging CI/CD pipelines
* Operating self-hosted runners
* Understanding infrastructure dependencies
* Handling cloud deployment failures
* Automating infrastructure provisioning workflows

---

# Author

## Kryptcloud

Cloud & DevOps Engineering Project

Terraform-Based AWS Production Infrastructure Foundation with GitHub Actions CI/CD Automation.
