# How to Destroy the AWS Infrastructure

## ⚠️ **CRITICAL WARNING**

**This guide will completely destroy your PetClinic environment and all associated resources.**

- ❌ **All data will be permanently lost**
- ❌ **All infrastructure will be deleted**
- ❌ **All configurations will be removed**
- ❌ **This action cannot be undone**

**Only proceed if you are absolutely certain you want to destroy the entire environment.**

---

## ✅ Pre-Destruction Checklist

### Mandatory Verification Steps

```bash
# 1. Confirm you're in the correct environment
kubectl config current-context

# 2. List all resources that will be destroyed
kubectl get all --all-namespaces
```

### Environment Verification
- [ ] **Correct Cluster**: Verified PetClinic cluster (not production)
- [ ] **Backup Completed**: All critical data backed up
- [ ] **Dependencies Checked**: No other systems depend on this environment

---

## 💾 Data Backup Procedures

### Database Backup

```bash
# Get the database pod name
POD_NAME=$(kubectl get pods -l app=petclinic -o jsonpath="{.items[0].metadata.name}")

# Create a database backup
kubectl exec -it $POD_NAME -- pg_dump -U petclinicadmin -d petclinic > final-backup-$(date +%Y%m%d-%H%M%S).sql
```

---

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

## ✅ Verification Procedures

### AWS Resource Verification

```bash
# Check EKS clusters
aws eks list-clusters --region us-east-1 | grep petclinic

# Check ECR repositories
aws ecr describe-repositories --region us-east-1 | grep petclinic

# Check RDS instances
aws rds describe-db-instances --region us-east-1 | grep petclinic

# Check VPCs
aws ec2 describe-vpcs --region us-east-1 | grep petclinic
```

## 💰 Cost Verification

### Final Cost Check

```bash
# Check for any remaining billable resources
aws ce get-cost-and-usage \
    --time-period Start=$(date -d "-1 day" +%Y-%m-%d),End=$(date +%Y-%m-%d) \
    --granularity DAILY \
    --metrics BlendedCost \
    --group-by Type=DIMENSION,Key=SERVICE
```