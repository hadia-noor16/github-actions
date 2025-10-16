# GitHub Actions

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

    
🔗 **Explore the Code Repository**
https://github.com/hadia-noor16/github-actions
