# PetClinic DevOps Project Master Setup Guide

## Overview

This guide provides complete step-by-step instructions for deploying the Spring PetClinic application with a full CI/CD pipeline. This guide is designed for new users who want to deploy the project from scratch.

**What You'll Deploy:**
- A Continuous Integration and Continuous Deployment (CI/CD) pipeline using GitHub Actions.
- An Amazon EKS (Elastic Kubernetes Service) cluster to host the application.
- An Amazon RDS (Relational Database Service) for PostgreSQL as the application's database.
- An Amazon ECR (Elastic Container Registry) to store the application's Docker images.

**Estimated Total Time:** 1-2 hours
**Skill Level:** Intermediate
**Prerequisites:** AWS Account, GitHub Account, Basic DevOps Knowledge

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Environment Setup](#environment-setup)
3. [Infrastructure Deployment](#infrastructure-deployment)
4. [Application Deployment](#application-deployment)
5. [Verification](#verification)
6. [Cleanup](#cleanup)

---

## Prerequisites

### Required Tools

Before you begin, you need to have the following tools installed on your local machine:

- **AWS CLI:** The AWS Command Line Interface is used to interact with AWS services.
- **Terraform:** Terraform is used to provision the infrastructure as code.
- **kubectl:** kubectl is the command-line tool for interacting with the Kubernetes cluster.
- **Git:** Git is used for version control.

### AWS Account Setup

You will need an AWS account with sufficient permissions to create the following resources:

- VPC, Subnets, Internet Gateway, NAT Gateway, EIP, Route Tables
- EKS Cluster, Node Group
- RDS Instance, Subnet Group
- ECR Repository
- IAM Roles and Policies

### GitHub Account Setup

You will need a GitHub account to fork the repository and configure the CI/CD pipeline.

---

## Environment Setup

### 1. Fork and Clone the Repository

First, you need to fork the `spring-petclinic` repository to your own GitHub account. Then, clone the forked repository to your local machine:

```bash
git clone https://github.com/<YOUR_USERNAME>/spring-petclinic.git
cd spring-petclinic
```

### 2. Configure AWS Credentials

Configure the AWS CLI with your AWS credentials. You can do this by running the following command and following the prompts:

```bash
aws configure
```

### 3. Configure GitHub Secrets

In your forked GitHub repository, you need to configure the following secrets:

- `AWS_ACCESS_KEY_ID`: Your AWS access key ID.
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key.
- `AWS_REGION`: The AWS region where you want to deploy the infrastructure (e.g., `us-east-1`).
- `AWS_ACCOUNT_ID`: Your AWS account ID.
- `SONAR_TOKEN`: Your SonarQube token (optional).
- `SONAR_HOST_URL`: Your SonarQube host URL (optional).

---

## Infrastructure Deployment

The infrastructure for this project is provisioned using Terraform.

1.  **Navigate to the Terraform directory:**
    ```bash
    cd terraform
    ```

2.  **Initialize Terraform:**
    ```bash
    terraform init
    ```

3.  **Review the Terraform plan:**
    ```bash
    terraform plan
    ```

4.  **Apply the Terraform plan:**
    ```bash
    terraform apply
    ```

This will provision the VPC, EKS cluster, RDS database, and other necessary resources.

---

## Application Deployment

The application is deployed automatically by the CI/CD pipeline when you push a change to the `main` branch.

1.  **Make a change to the code:**
    You can make a small change to any file in the repository to trigger the pipeline. For example, you can add a comment to the `README.md` file.

2.  **Commit and push the change:**
    ```bash
    git add .
    git commit -m "Trigger CI/CD pipeline"
    git push origin main
    ```

This will trigger the `Java CI with Maven` workflow, which will build, test, and push the Docker image to ECR. On successful completion, the `Continuous Deployment` workflow will be triggered, which will deploy the application to the EKS cluster.

---

## Verification

### 1. Verify the Deployment

After the pipeline has run, you can verify that the application has been deployed successfully by running the following commands:

-   `kubectl get pods`: This will show you the status of the application pods. You should see a pod with a name like `petclinic-xxxxxxxxxx-xxxxx` in the `Running` state.
-   `kubectl get services`: This will show you the status of the application service. You should see a service named `petclinic` with a `LoadBalancer` type.

### 2. Access the Application

Once the service is running, you can get the external IP address of the LoadBalancer by running the following command:

```bash
kubectl get svc petclinic -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
```

You can then open this IP address in your web browser to access the application.

---

## Cleanup

To destroy all the resources created by this project, you can use the `destroy-aws-infra.sh` script.

**Warning:** This script is destructive and will permanently delete all the AWS resources created by this project.

To run the script, you must be in the `terraform` directory. Navigate to the `terraform` directory and run the following command:

```bash
../scripts/destroy-aws-infra.sh
```
