# How to Destroy the AWS Infrastructure

This document provides a guide on how to safely and completely destroy all the AWS infrastructure created by this project.

## Option 1: Using Terraform (Recommended)

The recommended and safest way to destroy the infrastructure is to use the `terraform destroy` command. This will ensure that all resources created by Terraform are properly removed.

### Steps:

1.  **Navigate to the Terraform directory:**
    ```bash
    cd /home/geek/2025-DevOps-Projects/CI-CD-Projects/spring-petclinic/terraform
    ```

2.  **Preview the changes (optional but recommended):**
    Run the `terraform plan -destroy` command to see a list of all the resources that will be destroyed.
    ```bash
    terraform plan -destroy
    ```

3.  **Destroy the infrastructure:**
    Run the `terraform destroy` command and type `yes` when prompted to confirm.
    ```bash
    terraform destroy
    ```

## Option 2: Manual Destruction (Not Recommended)

Manually destroying the resources is not recommended as it is error-prone and you may miss some resources. However, if you need to do it, you can use the audit script to identify the resources and then delete them from the AWS console.

## Post-Destruction Verification

After destroying the infrastructure, it is a good practice to manually check the AWS console to ensure that all resources have been deleted. Pay special attention to the following:

*   **EC2:** Check for any running instances, security groups, and NAT gateways.
*   **EKS:** Check for any clusters and node groups.
*   **RDS:** Check for any database instances and subnet groups.
*   **VPC:** Check for any VPCs, subnets, route tables, and internet gateways.
*   **ECR:** Check for any container repositories. Note that Terraform does not delete ECR repositories that contain images. You will need to manually delete the images and then the repository.
*   **S3:** Check for any S3 buckets.
*   **CloudWatch:** Check for any log groups.
