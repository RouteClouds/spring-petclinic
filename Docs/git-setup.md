# Git Workflow and Branching Strategy

This document outlines the Git setup and branching strategy for the DevOps implementation of the Spring PetClinic project.

## 1. Remote Repository Setup

To work on this project without impacting the original source, we use a forked repository on GitHub. This provides a personal space to save changes and manage the project.

### Steps Taken:

1.  **Forking**: The original `spring-projects/spring-petclinic` repository was forked into your personal GitHub account.

2.  **Updating the Local Clone**: The local repository's remote URL was updated to point to your personal fork.

    ```bash
    # Command used to update the remote named 'origin'
    git remote set-url origin git@github.com:RouteClouds/spring-petclinic.git
    ```

## 2. Branching Strategy

For the purpose of this training project, we are adopting a simple, single-branch workflow. All work will be committed directly to the `main` branch.

While multi-branch workflows (like GitFlow) are common in team environments to manage features and releases, a single-branch strategy is sufficient for solo projects and learning exercises. It simplifies the process by ensuring the `main` branch always contains the latest version of our work.