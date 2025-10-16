# GitHub Actions

**Project Overview**

**Introduction**

A demonstration of how Terraform modules simplify infrastructure management by enabling code reusability, consistency, and reduced redundancy.

**Key Features**
1. Reusability : You can write infrastructure code once and reuse it across projects or environments.
2. Organization & Maintainability: The modular structure is easy to maintain and read
3. Consistency & Best Practices: It helps organization with maintaining standards like naming convention, tagging strategies etc.
4. Easier Testing & Debugging: You can test each module independently.
5. Reduced Human Error : By reusing verified modules, you avoid typos, wrong resource arguments, or misconfigured dependencies.
6. Scalability : When you scale infrastructure (e.g., add another environment, region, or service), you just reuse existing modules — no need to copy-paste or modify tons of .tf files.

**VPC Confriguration**
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
