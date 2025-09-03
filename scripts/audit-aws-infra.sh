#!/bin/bash

# This script audits the AWS resources created by the PetClinic project and generates a markdown report.

PROJECT_NAME="petclinic"
REPORT_FILE="aws-infra-report.md"

# Function to query for resources and append to the report
query_resources() {
  local resource_type=$1
  local query=$2
  local headers=$3
  
  echo "### $resource_type" >> $REPORT_FILE
  echo "" >> $REPORT_FILE
  echo "$headers" >> $REPORT_FILE
  echo "-----------------" >> $REPORT_FILE
  
  aws $query --filters "Name=tag:Name,Values=${PROJECT_NAME}-*" --output text >> $REPORT_FILE
  
  echo "" >> $REPORT_FILE
}

# Start the report
echo "# AWS Infrastructure Report for ${PROJECT_NAME}" > $REPORT_FILE
echo "" >> $REPORT_FILE

# Query for resources
query_resources "VPCs" "ec2 describe-vpcs --query 'Vpcs[].[VpcId, CidrBlock, Tags[?Key==`Name`].Value | [0]]'" "| VPC ID | CIDR Block | Name |"
query_resources "Subnets" "ec2 describe-subnets --query 'Subnets[].[SubnetId, CidrBlock, AvailabilityZone, Tags[?Key==`Name`].Value | [0]]'" "| Subnet ID | CIDR Block | AZ | Name |"
query_resources "Internet Gateways" "ec2 describe-internet-gateways --query 'InternetGateways[].[InternetGatewayId, Attachments[0].VpcId, Tags[?Key==`Name`].Value | [0]]'" "| IGW ID | VPC ID | Name |"
query_resources "NAT Gateways" "ec2 describe-nat-gateways --query 'NatGateways[].[NatGatewayId, VpcId, SubnetId, State, Tags[?Key==`Name`].Value | [0]]'" "| NAT GW ID | VPC ID | Subnet ID | State | Name |"
query_resources "EIPs" "ec2 describe-addresses --query 'Addresses[].[PublicIp, AllocationId, AssociationId, Domain, Tags[?Key==`Name`].Value | [0]]'" "| Public IP | Allocation ID | Association ID | Domain | Name |"
query_resources "Route Tables" "ec2 describe-route-tables --query 'RouteTables[].[RouteTableId, VpcId, Tags[?Key==`Name`].Value | [0]]'" "| Route Table ID | VPC ID | Name |"
query_resources "IAM Roles" "iam list-roles --query 'Roles[?starts_with(RoleName, `${PROJECT_NAME}-`)].[RoleName, Arn]'" "| Role Name | ARN |"
query_resources "EKS Clusters" "eks list-clusters --query 'clusters[?starts_with(@, `${PROJECT_NAME}-`)] | [] | [*] | join(`, `, @)'" "| Cluster Name |"
query_resources "EKS Node Groups" "eks list-nodegroups --cluster-name ${PROJECT_NAME}-cluster --query 'nodegroups[]' | [] | [*] | join(`, `, @)'" "| Node Group Name |"
query_resources "RDS DB Instances" "rds describe-db-instances --query 'DBInstances[?starts_with(DBInstanceIdentifier, `${PROJECT_NAME}-`)].[DBInstanceIdentifier, DBInstanceClass, Engine, DBSubnetGroup.DBSubnetGroupName, DBInstanceStatus]'" "| DB Instance ID | Class | Engine | Subnet Group | Status |"
query_resources "RDS DB Subnet Groups" "rds describe-db-subnet-groups --query 'DBSubnetGroups[?starts_with(DBSubnetGroupName, `${PROJECT_NAME}-`)].[DBSubnetGroupName, VpcId]'" "| Subnet Group Name | VPC ID |"
query_resources "Security Groups" "ec2 describe-security-groups --query 'SecurityGroups[?starts_with(GroupName, `${PROJECT_NAME}-`)].[GroupId, GroupName, VpcId]'" "| Security Group ID | Name | VPC ID |"

echo "Report generated at ${REPORT_FILE}"
