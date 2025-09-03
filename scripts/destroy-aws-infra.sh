#!/bin/bash

# This script destroys the AWS infrastructure created by the PetClinic project.

# Check if terraform is installed
if ! [ -x "$(command -v terraform)" ]; then
  echo 'Error: terraform is not installed.' >&2
  exit 1
fi

# Check if the user is in the correct directory
if [ ! -f "main.tf" ]; then
  echo "Error: This script must be run from the terraform directory."
  echo "Please cd to /home/geek/2025-DevOps-Projects/CI-CD-Projects/spring-petclinic/terraform"
  exit 1
fi

echo "This script will destroy all the AWS infrastructure created by the PetClinic project."
echo "Please review the plan below before proceeding."

# Run terraform plan -destroy
terraform plan -destroy

# Ask for confirmation
read -p "Are you sure you want to destroy the infrastructure? (yes/no) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# Run terraform destroy
terraform destroy -auto-approve
