# Git Workflow and Branching Strategy

This document outlines the Git setup and branching strategy for the DevOps implementation of the Spring PetClinic project.

## 1. Remote Repository Setup

To work on this project without impacting the original source, we use a forked repository on GitHub. This provides a personal space to save changes and manage the project.

### Steps Taken:

1.  **Forking**: The original `spring-projects/spring-petclinic` repository was forked into your personal GitHub account.

2.  **Updating the Local Clone**: The local repository was initially cloned from the original project. We updated its remote URL to point to your personal fork, enabling you to push changes.

    ```bash
    # Command used to update the remote named 'origin'
    git remote set-url origin git@github.com:RouteClouds/spring-petclinic.git

    # Command to verify the change
    git remote -v
    ```

## 2. Branching Strategy

We will adopt a simplified **GitFlow** model. This involves using different branches for specific purposes, which is a critical practice for maintaining code quality and enabling CI/CD automation.

### Core Branches

*   `main`: This branch is the primary source of truth. It should **always** contain stable, production-ready code. We will not commit directly to this branch.
*   `develop`: This is the primary development branch. All new features will be branched from and merged back into `develop`. It represents the latest state of development work.

### Why Not Work Directly on `main`?

Working on separate branches is a fundamental DevOps practice for several key reasons:

1.  **Stability and Safety**: It keeps the `main` branch clean and stable. You can work on new, experimental features in a `develop` or `feature` branch without any risk of breaking the main codebase.

2.  **Isolation**: Each branch is an isolated environment. If a new feature goes wrong, the branch can be fixed or discarded without impacting any other work.

3.  **Code Reviews (Pull Requests)**: This workflow is essential for collaboration and quality control. Changes made in a branch are proposed to be merged into `develop` via a **Pull Request (PR)**. This creates an opportunity for team members to review the code, suggest improvements, and approve the changes before they are integrated.

4.  **Automated CI/CD Triggers**: Our pipeline will be configured to perform different actions based on the branch. For example:
    *   A push to `develop` might deploy to a **staging environment**.
    *   A merge into `main` will trigger a deployment to **production**.
    Committing every small change directly to `main` would be chaotic and would bypass these critical quality and deployment gates.

### Day-to-Day Workflow

1.  Start new work by creating a `feature` branch from `develop`: `git checkout -b feature/new-login-page develop`
2.  Commit your changes to the feature branch.
3.  When the feature is complete, open a Pull Request to merge it into `develop`.
4.  After review and approval, the PR is merged.
5.  Periodically, changes from `develop` will be merged into `main` for a production release.
