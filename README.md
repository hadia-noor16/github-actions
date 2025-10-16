# GitHub Actions using Terraform modules

**Project Overview**

**Introduction**

**GitHub Actions**

GitHub Actions is a powerful CI/CD (Continuous Integration and Continuous Deployment) platform that automates workflows directly within your GitHub repository. It enables teams to build, test, and deploy applications seamlessly. 

**Key Features**
1. Native Integration with GitHub: No need for external CI/CD tools — everything runs inside your existing GitHub environment.
2. Continuous Integration and Deployment: GitHub Actions automatically builds, tests, and deploys code whenever changes are made.
3. Secrets and Security: GitHub Actions lets you securely store and use secrets (API keys, credentials, etc.) for use in workflows — ensuring sensitive information is never exposed in code.
4. Visibility and Collaboration: Workflows show up directnly in pull requests, commits, and repository Actions tabs, making it easy to see what succeeded of failed, who ran the workflow manually or what triggered the workflow to run.
5. Infrastructure as Code Automation: When used with Terraform, GitHub Actions enables full infrastructure automation like provisioning AWS resources, validate and apply Terraform plans.

**Terraform Modules**

A demonstration of how Terraform modules simplify infrastructure management by enabling code reusability, consistency, and reduced redundancy.

**Key Features**

1. Reusability : You can write infrastructure code once and reuse it across projects or environments.
2. Organization & Maintainability: The modular structure is easy to maintain and read
3. Consistency & Best Practices: It helps organization with maintaining standards like naming convention, tagging strategies etc.
4. Easier Testing & Debugging: You can test each module independently.
5. Reduced Human Error : By reusing verified modules, you avoid typos, wrong resource arguments, or misconfigured dependencies.
6. Scalability : When you scale infrastructure (e.g., add another environment, region, or service), you just reuse existing modules — no need to copy-paste or modify tons of .tf files.

**Infrastructure Deployment**
1. Build VPC network ( 196.128.0.0/16 ) 
2. Create Internet Gateway for VPC.
3. Create Public and Private Subnets along with Route tables.
4. Attach Public and private subnets with associated Route Table accordingly, to route the default traffic to IGW for inbound/outbound internet connection.
5. Create Security Group for EC2 Jenkins server allowing port 22, port 80, port 443, and port 8080 for Jenkins.
6. Create Remote S3 with DynamoDb for state locking.
7. Create Target Group and register EC2 server.
8. Create Application Load balancer in Public Subnet and add Target Group as target.
9. Create SSL certificate for your domain and create R53 records with it.
10. Update route53 hosted zone with CNAME record routing the traffic to ALB.
11. Created deploy.yml file to create all the resources, and clean.yml file to schedule a cron job to destroy the infrastructure at midnight.

    
🔗 **Explore the Code Repository**
https://github.com/hadia-noor16/github-actions



# Code pushed to main branch that triggers GitHub actions workflow to create the infrastructure:
<img width="3757" height="2007" alt="#2" src="https://github.com/user-attachments/assets/36977b13-2c36-40cc-9ddc-3b3ef84f48b6" />

# VPC with all the components
<img width="3140" height="1270" alt="#4-vpc" src="https://github.com/user-attachments/assets/5354148c-121e-4f10-a14b-d6c65b7d11bf" />

# Jenkins server created
<img width="3202" height="567" alt="#3" src="https://github.com/user-attachments/assets/4b2301fe-9acb-4e73-994d-ac5aedd823f6" />

# Setting up Jenkins
<img width="2892" height="2127" alt="domain runs jenkins" src="https://github.com/user-attachments/assets/627d127f-5a47-4b7c-8838-f0d12e5a6631" />

Login to the instance using EC2 Instance connect and run the command that's listed on Jenkins initial page to get the password for server.
<img width="3267" height="772" alt="password" src="https://github.com/user-attachments/assets/7cd7150e-ca7d-483d-a42d-c352ac9f2ae7" />

# Install Suggested Plugins and create first user:
<img width="2875" height="2097" alt="plugins" src="https://github.com/user-attachments/assets/8cc34382-bd04-4c53-8631-b676de0a644a" />
<img width="2270" height="1660" alt="login as admin" src="https://github.com/user-attachments/assets/18555f4b-b81d-4e19-9ab7-9f66dba2c60e" />

# Terraform cleanup scheduled for midnight
<img width="2852" height="677" alt="image" src="https://github.com/user-attachments/assets/8ff7a8c5-091e-4238-9e62-3c4a32ba04c8" />










