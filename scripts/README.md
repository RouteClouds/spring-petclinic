# Scripts for Managing the PetClinic Infrastructure

This directory contains scripts for managing the AWS infrastructure for the PetClinic project.

## `audit-aws-infra.sh`

This script audits the AWS resources created by the project and generates a markdown report named `aws-infra-report.md`.

### Usage

To run the script, navigate to the `scripts` directory and run the following command:

```bash
./audit-aws-infra.sh
```

## `destroy-aws-infra.sh`

This script destroys the AWS infrastructure created by the project.

**Warning:** This script is destructive and will permanently delete all the AWS resources created by this project.

### Usage

To run the script, you must be in the `terraform` directory. Navigate to the `terraform` directory and run the following command:

```bash
../scripts/destroy-aws-infra.sh
```

The script will first show you a plan of the resources that will be destroyed and then ask for confirmation before proceeding.
